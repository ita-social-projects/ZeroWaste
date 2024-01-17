# frozen_string_literal: true

module ApplicationHelper
  def current_locale?(locale)
    I18n.locale == locale
  end

  def switch_locale_to
    (I18n.locale == :en) ? :uk : :en
  end
end
