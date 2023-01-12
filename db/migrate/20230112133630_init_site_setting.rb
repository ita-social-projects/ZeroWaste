class InitSiteSetting < ActiveRecord::Migration[6.1]
  def up
    site_setting       = SiteSetting.instance
    site_setting.title = "ZeroWaste"
    site_setting.favicon.attach(
      io: File.open("app/assets/images/logo_zerowaste.png"),
      filename: "logo_zerowaste.png",
      content_type: "image/png"
    )

    site_setting.save!
  end
end
