# == Schema Information
#
# Table name: site_settings
#
#  id         :bigint           not null, primary key
#  title      :string           default("ZeroWaste"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
IMAGE_TYPE = "image/png"

FactoryBot.define do
  factory :site_setting do
    trait :with_valid_site_setting do
      title { "ZeroWaste" }
      favicon { Rack::Test::UploadedFile.new("app/assets/images/icons/favicon-48x48.png", IMAGE_TYPE) }
    end

    trait :invalid_site_setting do
      title { "" }
    end

    trait :new_title do
      title { "Test title" }
      favicon { Rack::Test::UploadedFile.new("app/assets/images/icons/favicon-48x48.png", IMAGE_TYPE) }
    end

    trait :custom_setting do
      title { "Custom Waste" }
      favicon { Rack::Test::UploadedFile.new("app/assets/images/user.png", IMAGE_TYPE) }
    end
  end
end
