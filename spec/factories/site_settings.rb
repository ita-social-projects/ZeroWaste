# == Schema Information
#
# Table name: site_settings
#
#  id         :bigint           not null, primary key
#  title      :string           default("ZeroWaste"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null

FactoryBot.define do
  factory :site_setting do
    trait :with_valid_site_setting do
      title { "ZeroWaste" }
      favicon { Rack::Test::UploadedFile.new("app/assets/images/icons/favicon-48x48.png", "image/png") }
    end

    trait :invalid_site_setting do
      title { "" }
    end

    trait :new_title do
      title { "Test title" }
      favicon { Rack::Test::UploadedFile.new("app/assets/images/icons/favicon-48x48.png", "image/png") }
    end

    trait :invalid_favicon do
      title { "ZeroWaste" }
      favicon { Rack::Test::UploadedFile.new("spec/fixtures/icons/favicon-181x182.png", "image/png") }
    end

    trait :custom_setting do
      title { "Custom Waste" }
      favicon { Rack::Test::UploadedFile.new("app/assets/images/user.png", "image/png") }
    end
  end
end
