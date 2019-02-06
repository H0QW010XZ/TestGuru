class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]

  def new; end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to cookies.delete(:return_to) || tests_path
    else
      flash.now[:alert] = 'Verify your Email and Password please'
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path, notice: 'Goodbye!'
  end
end
