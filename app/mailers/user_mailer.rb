# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: "zerowastemailer@gmail.com"

  def test_email(email, message = nil)
    @email   = email
    @message = message

    mail(to: @email, subject: I18n.t("mailer.test_mail.subject"))
  end
end
