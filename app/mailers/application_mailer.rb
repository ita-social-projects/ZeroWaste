# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "zerowastemailer@gmail.com"
  layout "mailer"
end
