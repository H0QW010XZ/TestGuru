class ApplicationMailer < ActionMailer::Base
  default from: %{"Test Guru" <mail@testguru0.com>}
  layout 'mailer'
end
