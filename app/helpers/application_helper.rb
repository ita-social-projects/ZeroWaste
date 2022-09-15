# frozen_string_literal: true

module ApplicationHelper
  LN = [
    { en: 'English' },
    { uk: 'Українська' }
  ].freeze

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

  def change_locale!
    ind = LN.find_index { | h | h.keys.first.to_s == I18n.locale.to_s }
    ind.nil? ? LN[0] : user_signed_in? ? LN[(ind + 1) % LN.length] : LN[ind - 1]
  end
end
