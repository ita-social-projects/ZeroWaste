module Translatable
  extend ActiveSupport::Concern

  class_methods do
    def translates(*attributes)
      attributes.each do |attribute|
        define_method(attribute) do
          translation_for(attribute)
        end
      end
    end

    def localized_column_for(attribute)
      locale_attr  = "#{I18n.locale}_#{attribute}"
      default_attr = "#{I18n.default_locale}_#{attribute}"

      if column_names.include?(locale_attr)
        locale_attr
      elsif column_names.include?(default_attr)
        default_attr
      else
        attribute
      end
    end
  end

  private

  def translation_for(attribute)
    locale_attr         = "#{I18n.locale}_#{attribute}"
    default_locale_attr = "#{I18n.default_locale}_#{attribute}"

    if respond_to?(locale_attr)
      public_send(locale_attr)
    elsif respond_to?(default_locale_attr)
      public_send(default_locale_attr)
    end
  end
end
