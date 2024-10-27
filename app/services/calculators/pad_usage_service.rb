class Calculators::PadUsageService
  attr_accessor :user_age, :menstruation_age, :menopause_age,
                :average_menstruation_cycle_duration,
                :pads_per_cycle, :pad_category

  PAD_PRICES = {
    budget: 2,
    average: 4,
    premium: 7
  }

  def initialize(user_age:, menstruation_age:, menopause_age:, average_menstruation_cycle_duration:,
    pads_per_cycle:, pad_category:)
    @user_age                            = user_age
    @menstruation_age                    = menstruation_age
    @menopause_age                       = menopause_age || 48.7
    @average_menstruation_cycle_duration = average_menstruation_cycle_duration
    @pads_per_cycle                      = pads_per_cycle
    @pad_category                        = (pad_category || :budget).to_sym
  end

  def calculate
    {
      already_used_products:,
      already_used_products_cost:,
      products_to_be_used:,
      products_to_be_used_cost:
    }
  end

  private

  def already_used_products
    menstruations_from_age_range(menstruation_age, user_age) * pads_per_cycle
  end

  def products_to_be_used
    menstruations_from_age_range(user_age, menopause_age) * pads_per_cycle
  end

  def already_used_products_cost
    already_used_products * PAD_PRICES[pad_category]
  end

  def products_to_be_used_cost
    products_to_be_used * PAD_PRICES[pad_category]
  end

  def menstruations_from_age_range(from_age, till_age)
    (till_age - from_age) * (365 / average_menstruation_cycle_duration)
  end
end
