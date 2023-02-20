# frozen_string_literal: true

module ApplicationHelper
  def current_site_setting
    site_setting = SiteSetting.instance

    if site_setting.invalid?
      site_setting.title = "ZeroWaste"
      unless site_setting.favicon.attached?
        site_setting.favicon.attach(
          io: File.open("app/assets/images/logo_zerowaste.png"),
          filename: "logo_zerowaste.png",
          content_type: "image/png"
        )
      end

      site_setting.save!
    end

    site_setting
  end

  def flash_messages
    {
      notice: notice,
      alert: alert
    }.compact_blank
  end

  def message_class_by_name(type)
    case type.to_s
    when "notice"
      "alert-success"
    when "alert"
      "alert-danger"
    else
      "alert-warning"
    end
  end

  def current_locale?(locale)
    I18n.locale == locale
  end

  def switch_locale_to
    (I18n.locale == :en) ? :uk : :en
  end
end
