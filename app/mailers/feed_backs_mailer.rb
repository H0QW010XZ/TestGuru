class FeedBacksMailer < ApplicationMailer
  def new_feedback(feedback)
    @feedback = feedback

    mail to: Admin.first.email, subject: "Test-guru feedback message from #{@feedback.name}"
  end
end
