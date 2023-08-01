# == Schema Information
#
# Table name: site_settings
#
#  id         :bigint           not null, primary key
#  title      :string           default("ZeroWaste"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :site_setting do
    trait :with_valid_site_setting do
      title { "ZeroWaste" }
      favicon { Rack::Test::UploadedFile.new("app/assets/images/logo_zerowaste.png", "image/png") }
    end

    trait :invalid_site_setting do
      title { "" }
    end

    trait :new_title do
      title { "Test title" }
      favicon { Rack::Test::UploadedFile.new("app/assets/images/logo_zerowaste.png", "image/png") }
    end
  end
end
