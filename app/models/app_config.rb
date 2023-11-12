# frozen_string_literal: true

# == Schema Information
#
# Table name: app_configs
#
#  id                 :bigint           not null, primary key
#  diapers_calculator :jsonb
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class AppConfig < ApplicationRecord
  acts_as_singleton

  public_class_method :find_by!, :all

  def update_diapers_calculator(params)
    self.diapers_calculator = Calculators::DiapersService.product_attributes(params)
    save
  end
end
