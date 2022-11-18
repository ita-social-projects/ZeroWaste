# frozen_string_literal: true

class String
  def pluralize(count = nil, locale = :en)
    locale = count if count.is_a?(Symbol)

    if count == 1
      dup
    else
      ActiveSupport::Inflector.pluralize(self, count, locale)
    end
  end
end

module InflectorExtensions
  def pluralize(word, count = nil, locale = :en)
    apply_inflections(word, inflections(locale).plurals, locale, count)
  end

  def apply_inflections(word, rules, locale = :en, count = nil)
    result = word.to_s.dup

    if word.blank? || inflections(locale).uncountables.uncountable?(result)
      return result
    end

    rules.each do |rule, replacement, range|
      if (range.nil? || range.include?(count)) && result.sub!(rule, replacement)
        break
      end
    end
    result
  end
end

module InflectionsExtensions
  def plural(rule, replacement, range = nil)
    super(rule, replacement)
    @plurals.first << range unless range.nil?
  end
end

module ActiveSupport
  module Inflector
    extend InflectorExtensions
  end
end

module ActiveSupport
  module Inflector
    class Inflections
      prepend InflectionsExtensions
    end
  end
end
