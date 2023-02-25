FactoryBot.define do
  factory :site_setting do
    title { "ZeroWaste" }

    trait :with_favicon do
      favicon { Rack::Test::UploadedFile.new('spec/fixtures/files/logo_zerowaste.png', 'image/png') }
    end
  end

  factory :invalid_site_setting, parent: :site_setting do
    title { "" }
  end
end
