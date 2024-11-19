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

class DiapersPeriod < ApplicationRecord
  belongs_to :category

  validates :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0, less_than: 1000 }, allow_blank: true

  validates :period_start,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  validates :period_end, presence: true
  validates :period_end,
            numericality: { only_integer: true, greater_than: :period_start, less_than_or_equal_to: 30 },
            allow_blank: true

  validates :usage_amount, presence: true
  validates :usage_amount,
            numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than: 100 },
            allow_blank: true

  scope :ordered, -> { order(:id) }

  def self.start_date(category)
    last_period = category.diapers_periods.order(:created_at).last

    last_period ? (last_period.period_end + 1) : 1
  end
end
