# frozen_string_literal: true

class String
  def pluralize(count = nil, locale = :en)
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
      if callback.is_a?(Proc) && !count.nil?
        replacement = callback.call(count) || replacement
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

module ActiveSupport::Inflector
  extend InflectorExtensions
end

class ActiveSupport::Inflector::Inflections
  prepend InflectionsExtensions
end
