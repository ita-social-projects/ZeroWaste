# frozen_string_literal: true
# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym 'RESTful'
# end

require 'inflector_extensions'

def generate_inflections_callback(one, few, many)
  lambda do |count|
    last2 = count.to_s[-2..].to_i
    last1 = count.to_s[-1].to_i

    return one if (last1 == 1) && (last2 != 11)
    return few if (2..4).include?(last1) && !(12..14).include?(last2)

    many
  end
end

diaper_inflections_callback = generate_inflections_callback(
  'підгузок',
  'підгузки',
  'підгузків'
)

month_inflections_callback = generate_inflections_callback(
  'місяць',
  'місяці',
  'місяців'
)

year_inflections_callback = generate_inflections_callback(
  'рік',
  'роки',
  'років'
)

ActiveSupport::Inflector.inflections(:uk) do |inflect|
  inflect.plural('місяць', 'місяців', month_inflections_callback)
  inflect.plural('рік', 'років', year_inflections_callback)
  inflect.plural('підгузок', 'підгузки', diaper_inflections_callback)
end
