require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "welcome_email" do
    let(:user) { create(:user) }
    let(:mail) { UserMailer.welcome_email(user) }

    it "renders the headers" do
      expect(mail.subject).to eq(I18n.t("mailer.welcome_mail.subject"))
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["zerowastemailer@gmail.com"])
    end

    it "renders the body" do
      expect(mail.body).to include(I18n.t("user_mailer.welcome_email.greeting", name: user.first_name))
      expect(mail.body).to include(I18n.t("user_mailer.welcome_email.email", email: user.email))
      expect(mail.body).to include(I18n.t("user_mailer.welcome_email.password", password: user.password))
      expect(mail.body).to include(I18n.t("user_mailer.welcome_email.to_login"))
      expect(mail.body).to include("ZeroWaste")
      expect(mail.body).to include(I18n.t("user_mailer.welcome_email.thanks"))
    end
  end
end
