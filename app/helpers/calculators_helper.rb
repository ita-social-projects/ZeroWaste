# frozen_string_literal: true

module CalculatorsHelper
  def extract_max_selector(fields)
    fields.map { |field| field.selector&.gsub(/\D/, '').to_i }.max
  end

  def render_email_receiver_checkbox
    return unless user_signed_in?

    arr = []
    arr << (simple_format '',
                          { type: 'checkbox', name: 'email_receiver',
                            id: 'checkbox_submit' }, wrapper_tag: 'input')
    arr << (simple_format t('calculators.calculator.email_receiver_checkbox'),
                          { for: 'checkbox_submit' }, wrapper_tag: 'label')
    content_tag(:div, class: 'flex-item') do
      arr.join(' ').html_safe
    end
  end
end
