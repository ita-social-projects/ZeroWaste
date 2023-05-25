if Flipper::Adapters::ActiveRecord::Feature.table_exists?
  class Flipper::Feature
    delegate :en_description, :en_description=, to: :feature_record
    delegate :uk_description, :uk_description=, to: :feature_record

    alias_method :name, :key

    def description
      public_send("#{I18n.locale}_description")
    end

    private

    def feature_record
      @feature_record ||= Flipper::Adapters::ActiveRecord::Feature.find_or_create_by(key: key)
    end
  end
else
  raise ActiveRecord::PendingMigrationError
end
