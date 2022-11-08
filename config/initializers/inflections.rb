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

ActiveSupport::Inflector.inflections(:uk) do |inflect|
  inflect.plural('місяць', 'місяців', (5..11).to_a << 0)
  inflect.plural('місяць', 'місяці', (2..4).to_a)
  inflect.plural('рік', 'років', [0])
  inflect.plural('рік', 'роки', [2])
end
