# frozen_string_literal: true

module CalculatorsHelper
  def extract_max_selector(fields)
    fields.map { |field| field.selector&.gsub(/\D/, "").to_i }.max
  end

  def collection_product_category
    [t(".form.budgetary"),
      t(".form.medium"),
      t(".form.premium")]
  end

  def link_to_external(url, link_text)
    link_to(url, target: "_blank") do
      concat(
        content_tag(:span, link_text, class: 'link-text') +
        content_tag(:i, nil, class: 'fas fa-external-link-alt')
      )
    end
  end

  def zero_waste_url(locale: nil, href:)
    if locale.present?
      "https://zerowastelviv.org.ua/#{locale.to_s}/#{href}"
    else
      "https://zerowastelviv.org.ua/#{href}"
    end
  end

  def url_due_to_locale
    if I18n.locale == :en
     'https://zerowastelviv.org.ua/en/zero-waste-nappies-en/'
    else
      'https://zerowastelviv.org.ua/zero-waste-nappies/'
    end
  end
end
