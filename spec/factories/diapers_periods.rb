# == Schema Information
#
# Table name: diapers_periods
#
#  id           :bigint           not null, primary key
#  period_end   :integer          not null
#  period_start :integer          not null
#  price        :decimal(8, 2)    not null
#  usage_amount :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  category_id  :bigint           not null
#
# Indexes
#
#  index_diapers_periods_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
FactoryBot.define do
  factory :diapers_period do
    category factory: [:category]
    period_start { 1 }
    period_end { 30 }
    price { 10 }
    usage_amount { 5 }
  end
end
