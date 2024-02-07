class Account::DiapersPeriodsController < Account::BaseController
  # repond_with format: :turbo_stream, only: []

  def index
    set_category
    @diapers_periods = @category.diapers_periods
  end

  def new
    set_category
    set_period_start
    @diapers_period = DiapersPeriod.new(category_id: @category.id, period_start: @period_start)
  end

  def edit
    set_diapers_period
  end

  def create
    set_category
    @diapers_periods = @category.diapers_periods
    @diapers_period  = @category.diapers_periods.build(diapers_period_params)

    if @diapers_period.save
      respond_to :turbo_stream, status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    set_category
    @diapers_periods = @category.diapers_periods
    set_diapers_period

    if @diapers_period.update(diapers_period_params)
      respond_to :turbo_stream, status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    set_diapers_period

    if @diapers_period.destroy
      respond_to :turbo_stream
    else
      redirect_to account_site_setting_path, alert: "Can't delete diapers period."
    end
  end

  def available_categories
    @categories = Category.available_categories
  end

  def categories
    @categories_with_periods = Category.categories_with_periods
  end

  def destroy_category
    set_category

    if @category.diapers_periods.destroy_all
      respond_to :turbo_stream
    else
      redirect_to account_site_setting_path, alert: "Can't delete diapers periods from category."
    end
  end

  private

  def diapers_period_params
    params.require(:diapers_period).permit(:price, :period_start, :period_end, :usage_amount, :category_id)
  end

  def set_diapers_period
    @diapers_period = DiapersPeriod.find(params[:id])
  end

  def set_category
    category_id = params[:diapers_period].present? ? params[:diapers_period][:category_id] : params[:category_id]
    @category   = Category.find(category_id)
  end

  def set_period_start
    last_period   = @category.diapers_periods.order(:created_at).last
    @period_start = last_period ? (last_period.period_end + 1) : 1
  end
end
