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
  end

  private

  def translation_for(attribute)
    public_send("#{I18n.locale}_#{attribute}") ||
      public_send("#{I18n.default_locale}_#{attribute}") ||
      public_send(attribute)
  end
end
