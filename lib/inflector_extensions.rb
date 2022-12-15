# frozen_string_literal: true

class String
  def pluralize(count: nil, locale: :en)
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

    rules.each do |rule, replacement, callback|
      if callback.is_a?(Proc) && count.is_a?(Numeric)
        default_replacement = replacement
        replacement = callback.call(count)
        replacement = default_replacement if replacement.nil?
      end

      break if result.sub!(rule, replacement)
    end
    result
  end
end

module InflectionsExtensions
  def plural(rule, replacement, callback = nil)
    super(rule, replacement)
    @plurals.first << callback unless callback.nil?
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
