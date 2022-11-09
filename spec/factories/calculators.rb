# frozen_string_literal: true

# == Schema Information
#
# Table name: calculators
#
#  id         :bigint           not null, primary key
#  uuid       :uuid             not null
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#  preferable :boolean          default(FALSE)
#
FactoryBot.define do
  factory :calculator do
    name { 'Diapers Calculator' }
    slug { 'diapers' }
  end
end
