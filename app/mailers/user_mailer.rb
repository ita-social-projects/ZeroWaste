# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: "zerowastemailer@gmail.com"

  def welcome_email(user)
    @user = user
    @url  = "#{default_url_options[:host]}:#{default_url_options[:port]}"
    mail(to: @user.email, subject: I18n.t("mailer.welcome_mail.subject"))
  end
end
