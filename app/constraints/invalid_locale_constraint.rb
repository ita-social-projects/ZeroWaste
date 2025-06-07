class InvalidLocaleConstraint
  def matches?(request)
    segments          = request.path.split("/")
    locale            = segments[1]
    prefix            = segments[2..3].join("/")
    available_locales = I18n.available_locales.map(&:to_s)
    locale.present? && available_locales.exclude?(locale) && prefix == "api/v2"
  end
end
