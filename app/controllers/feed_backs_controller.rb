class FeedBacksController < ApplicationController

  skip_before_action :authenticate_user!

  def new
    @feedback = FeedBack.new
  end

  def create
    @feedback = FeedBack.new(feedback_params)

    if @feedback.valid?
      FeedBacksMailer.new_feedback(@feedback).deliver_now
      redirect_to new_feed_back_path
      flash[:notice] = t('.notice')
    else
      flash[:alert] = t('.alert')
      render :new
    end
  end

  private

  def feedback_params
    params.require(:feed_back).permit(:name, :email, :message)
  end
end
