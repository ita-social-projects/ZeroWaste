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

  def change_locale!
    sl = I18n.locale.to_s
    if !user_signed_in?
      sl = (sl == 'en' ? 'uk' : 'en').to_sym
    else
        if sl == 'uk'
           sl = 'en'.to_sym
        else
           sl = 'uk'.to_sym
        end
    end
    sl == :uk ? { sl => 'Українська' } : { sl => 'English' }
  end
end
