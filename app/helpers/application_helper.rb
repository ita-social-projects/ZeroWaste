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
    sl = I18n.locale.to_s
    res = LN.each_with_index do |h, ind|
      if sl == h.keys.first.to_s
        if user_signed_in?
          i = (ind + 1) % LN.length
        else
          i = ind - 1
        end
        break LN[i]
      end
    end
    res.empty? ? LN[0] : res
  end
end
