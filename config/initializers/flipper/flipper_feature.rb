class Flipper::Feature
  alias_method :name, :key

  def description
    send("description_#{I18n.locale}") || description_en
  end

  def description_en
    feature_record.description_en
  end

  def description_en=(value)
    feature_record.update(description_en: value)
  end

  def description_uk
    feature_record.description_uk
  end

  def description_uk=(value)
    feature_record.update(description_uk: value)
  end

  private

  def feature_record
    @feature_record ||= Flipper::Adapters::ActiveRecord::Feature.find_or_create_by(key: key)
  end
end
