# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: "zerowastemailer@gmail.com"

  def welcome_email(user)
    @user = user
    @url  = root_url
    mail(to: @user.email, subject: I18n.t("mailer.welcome_mail.subject"))
  end
end
