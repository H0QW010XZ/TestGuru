class FeedBacksController < ApplicationController
  def new
    @feedback = FeedBack.new
  end

  def create
    @feedback = FeedBack.new(feedback_params)
    @feedback.user = current_user

    if @feedback.save!
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
    params.require(:feed_back).permit(:message)
  end
end
