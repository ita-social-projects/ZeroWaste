class Flipper::Feature
  alias_method :name, :key

  def description
    public_send("#{I18n.locale}_description") || en_description
  end

  def en_description
    feature_record.en_description
  end

  def en_description=(value)
    feature_record.update(en_description: value)
  end

  def uk_description
    feature_record.uk_description
  end

  def uk_description=(value)
    feature_record.update(uk_description: value)
  end

  private

  def feature_record
    @feature_record ||= Flipper::Adapters::ActiveRecord::Feature.find_or_create_by(key: key)
  end
end
