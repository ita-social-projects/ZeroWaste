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

  def years_number
    (0..2).map { |year| t("calculators.date.years", count: year) }
  end

  def month_number(style)
    case style
    when "old" then (0..11).map { |month| t("calculators.date.months", count: month) }
    when "new" then (0..11).to_a
    end
  end

  def link_to_external(text:, url:, **options)
    link_to(url, target: "_blank", rel: "noopener", **options) do
      concat(
        content_tag(:span, text, class: "ms-0") +
        content_tag(:i, nil, class: "fas fa-external-link-alt ms-1")
      )
    end
  end
end
