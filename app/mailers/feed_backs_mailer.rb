class FeedBacksMailer < ApplicationMailer
  default to: -> { Admin.pluck(:email) }
  def new_feedback(feedback)
    @feedback = feedback

    mail subject: "Test-guru feedback message from #{@feedback.name}"
  end
end
