class Account::DiapersPeriodsController < Account::BaseController
  # repond_with format: :turbo_stream, only: []

  def index
    set_category
    @diapers_periods = @category.diapers_periods.order(:id)
    unfilled_categories
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
    @diapers_periods = @category.diapers_periods.order(:id)
    @diapers_period  = @category.diapers_periods.build(diapers_period_params)
    unfilled_categories

    if @diapers_period.save
      respond_to :turbo_stream, status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    set_category
    @diapers_periods = @category.diapers_periods.order(:id)
    set_diapers_period
    unfilled_categories

    if @diapers_period.update(diapers_period_params)
      respond_to :turbo_stream, status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    set_diapers_period
    set_category
    unfilled_categories
    @diapers_periods = @category.diapers_periods.order(:id)

    if @diapers_period.destroy
      respond_to :turbo_stream
    else
      redirect_to account_site_setting_path, alert: t("notifications.diapers_period_not_deleted")
    end
  end

  def available_categories
    @categories = Category.available_categories
  end

  def categories
    @categories_with_periods = Category.categories_with_periods
    unfilled_categories
  end

  def destroy_category
    set_category

    if @category.diapers_periods.destroy_all
      respond_to :turbo_stream
    else
      redirect_to account_site_setting_path, alert: t("notifications.category_diapers_period_not_deleted")
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
    if params[:id]
      @diapers_period = DiapersPeriod.find(params[:id])
      @category       = @diapers_period.category
    else
      category_id = params[:diapers_period].present? ? params[:diapers_period][:category_id] : params[:category_id]
      @category   = Category.find(category_id)
    end
  end

  def set_period_start
    last_period   = @category.diapers_periods.order(:created_at).last
    @period_start = last_period ? (last_period.period_end + 1) : 1
  end

  def unfilled_categories
    @unfilled_categories = Category.unfilled_categories
  end
end
