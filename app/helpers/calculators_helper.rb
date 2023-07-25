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
      "#{link_text} <i class='fas fa-external-link-alt'></i>".html_safe
    end
  end

  def zero_waste_url(locale: nil, href:)
    if locale.present?
      "https://zerowastelviv.org.ua/#{locale.to_s}/#{href}"
    else
      "https://zerowastelviv.org.ua/#{href}"
    end
  end
end
