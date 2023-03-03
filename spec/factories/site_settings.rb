FactoryBot.define do
  factory :site_setting do
    trait :with_valid_site_setting do
      title { "ZeroWaste" }
      favicon { Rack::Test::UploadedFile.new("spec/fixtures/files/logo_zerowaste.png", "image/png") }
    end

    trait :invalid_site_setting do
      title { "" }
    end

    trait :new_title do
      title { "Test title" }
      favicon { Rack::Test::UploadedFile.new("spec/fixtures/files/logo_zerowaste.png", "image/png") }
    end
  end
end
