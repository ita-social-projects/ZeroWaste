class Account::DiapersPeriodsController < Account::BaseController
  def index
    @category            = Category.find(params[:category_id])
    @unfilled_categories = Category.with_unfilled_diapers_periods
    @diapers_periods     = @category.diapers_periods.order(:id)
  end

  def new
    @category       = Category.find(params[:category_id])
    @period_start   = DiapersPeriod.start_date(@category)
    @diapers_period = DiapersPeriod.new(category_id: @category.id, period_start: @period_start)
  end

  def edit
    @diapers_period = DiapersPeriod.find(params[:id])
  end

  def create
    @category            = Category.find(params[:diapers_period][:category_id])
    @unfilled_categories = Category.with_unfilled_diapers_periods
    @diapers_period      = @category.diapers_periods.build(diapers_period_params)
    @diapers_periods     = @category.diapers_periods.order(:id)

    if @diapers_period.save
      respond_to :turbo_stream
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @category            = Category.find(params[:diapers_period][:category_id])
    @unfilled_categories = Category.with_unfilled_diapers_periods
    @diapers_period      = DiapersPeriod.find(params[:id])
    @diapers_periods     = @category.diapers_periods.order(:id)

    if @diapers_period.update(diapers_period_params)
      respond_to :turbo_stream
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @diapers_period      = DiapersPeriod.find(params[:id])
    @category            = @diapers_period.category
    @unfilled_categories = Category.with_unfilled_diapers_periods
    @diapers_periods     = @category.diapers_periods.order(:id)

    if @diapers_period.destroy
      render formats: :turbo_stream, status: :see_other
    else
      redirect_to account_site_setting_path, alert: t("notifications.diapers_period_not_deleted")
    end
  end

  def available_categories
    @categories = Category.without_diapers_periods
  end

  def categories
    @unfilled_categories     = Category.with_unfilled_diapers_periods
    @categories_with_periods = Category.with_diapers_periods
  end

  def destroy_category
    @category = Category.find(params[:category_id])

    if @category.diapers_periods.destroy_all
      render formats: :turbo_stream, status: :see_other
    else
      redirect_to account_site_setting_path, alert: t("notifications.category_diapers_period_not_deleted")
    end
  end

  private

  def diapers_period_params
    params.require(:diapers_period).permit(:price, :period_start, :period_end, :usage_amount, :category_id)
  end
end
