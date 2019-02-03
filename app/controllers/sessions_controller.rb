class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]

  def new; end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to tests_path, success: 'You have successfully logged in!'
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
  end
end
