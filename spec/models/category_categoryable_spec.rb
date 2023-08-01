# frozen_string_literal: true

# == Schema Information
#
# Table name: category_categoryables
#
#  id                :bigint           not null, primary key
#  categoryable_type :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  category_id       :bigint
#  categoryable_id   :bigint
#
# Indexes
#
#  index_category_categoryables_on_category_id   (category_id)
#  index_category_categoryables_on_categoryable  (categoryable_type,categoryable_id)
#  unique_of_category_categoryables_index        (categoryable_type,categoryable_id,category_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
require "rails_helper"

RSpec.describe CategoryCategoryable, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:categoryable) }

    it { is_expected.to belong_to(:category) }
  end
end
