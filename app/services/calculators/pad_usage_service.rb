class Calculators::PadUsageService
  attr_accessor :user_age, :menstruation_age, :menopause_age,
                :average_menstruation_cycle_duration,
                :duration_of_menstruation, :disposable_products_per_day, :product_type, :pad_category

  PRODUCT_PRICES = {
    pads: {
      budget: 2,
      average: 4,
      premium: 7
    },
    tampons: {
      budget: 3,
      average: 5,
      premium: 8
    }
  }

  def initialize(user_age:, menstruation_age:, menopause_age:, average_menstruation_cycle_duration:,
    duration_of_menstruation:, disposable_products_per_day:, product_type:, pad_category:)
    @user_age                            = user_age
    @menstruation_age                    = menstruation_age
    @menopause_age                       = menopause_age || 48.7
    @average_menstruation_cycle_duration = average_menstruation_cycle_duration
    @duration_of_menstruation            = duration_of_menstruation
    @disposable_products_per_day         = disposable_products_per_day
    @product_type                        = product_type.to_sym
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
    menstruations_from_age_range(menstruation_age, user_age) * duration_of_menstruation * disposable_products_per_day
  end

  def products_to_be_used
    menstruations_from_age_range(user_age, menopause_age) * duration_of_menstruation * disposable_products_per_day
  end

  def already_used_products_cost
    already_used_products * PRODUCT_PRICES[product_type][pad_category]
  end

  def products_to_be_used_cost
    products_to_be_used * PRODUCT_PRICES[product_type][pad_category]
  end

  def menstruations_from_age_range(from_age, till_age)
    (till_age - from_age) * (365 / average_menstruation_cycle_duration)
  end
end
