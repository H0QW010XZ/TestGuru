class FeedBacksMailer < ApplicationMailer
  def new_feedback(feedback)
    @feedback = feedback

    mail to: admin_email, subject: "Test-guru feedback message from #{@feedback.user.email}"
  end

  private

  def admin_email
    User.find_by(type: 'Admin').email
  end
end
