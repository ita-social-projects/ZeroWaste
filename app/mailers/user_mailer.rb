# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'zerowastemailer@gmail.com'

  def test_email(email, message = nil)
    @email = email
    @message = message

    mail(to: @email, subject: 'Test email. No reply')
  end
end
