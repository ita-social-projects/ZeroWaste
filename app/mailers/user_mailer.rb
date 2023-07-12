# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: "zerowastemailer@gmail.com"

  def test_email(email, message = nil)
    @email   = email
    @message = message

    mail(to: @email, subject: I18n.t("mailer.test_mail.subject"))
  end

  def welcome_email
    @user = params[:user]
    @url  = 'https://zerowastelviv.org.ua'
    mail(to: @user.email, subject: 'Welcome to ZeroWaste')
  end
end
