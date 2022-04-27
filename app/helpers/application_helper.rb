# frozen_string_literal: true

module ApplicationHelper
  def flash_messages
    {
      notice: notice,
      alert: alert
    }.reject { |_key, message| message.blank? }
  end

  def message_class_by_name(type)
    if type.to_s == 'notice'
      'alert-success'
    elsif type.to_s == 'alert'
      'alert-danger'
    else
      'alert-warning'
    end
  end

  def current_locale?(locale)
    I18n.locale == locale
  end
end
