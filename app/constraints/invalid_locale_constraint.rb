class InvalidLocaleConstraint
  def matches?(request)
    segments          = request.path.split("/")
    locale            = segments[1]&.to_sym
    prefix            = segments[2..3].join("/")

    locale.present? && I18n.available_locales.exclude?(locale) && prefix == "api/v2"
  end
end
