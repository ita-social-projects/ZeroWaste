class Account::DiapersPeriodsController < Account::BaseController
  def index
    @category            = Category.find(params[:category_id])
    @unfilled_categories = DiapersPeriod.unfilled_categories
    @diapers_periods     = @category.diapers_periods.order(:id)
  end

  def new
    @category       = Category.find(params[:category_id])
    last_period     = @category.diapers_periods.order(:created_at).last
    @period_start   = last_period ? (last_period.period_end + 1) : 1
    @diapers_period = DiapersPeriod.new(category_id: @category.id, period_start: @period_start)
  end

  def edit
    @diapers_period = DiapersPeriod.find(params[:id])
  end

  def create
    @category            = Category.find(params[:diapers_period][:category_id])
    @unfilled_categories = DiapersPeriod.unfilled_categories
    @diapers_period      = @category.diapers_periods.build(diapers_period_params)
    @diapers_periods     = @category.diapers_periods.order(:id)

    if @diapers_period.save
      respond_to :turbo_stream, status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @category            = Category.find(params[:diapers_period][:category_id])
    @unfilled_categories = DiapersPeriod.unfilled_categories
    @diapers_period      = DiapersPeriod.find(params[:id])
    @diapers_periods     = @category.diapers_periods.order(:id)

    if @diapers_period.update(diapers_period_params)
      respond_to :turbo_stream, status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @diapers_period      = DiapersPeriod.find(params[:id])
    @category            = @diapers_period.category
    @unfilled_categories = DiapersPeriod.unfilled_categories
    @diapers_periods     = @category.diapers_periods.order(:id)

    if @diapers_period.destroy
      respond_to :turbo_stream
    else
      redirect_to account_site_setting_path, alert: t("notifications.diapers_period_not_deleted")
    end
  end

  def available_categories
    @categories = DiapersPeriod.available_categories
  end

  def categories
    @unfilled_categories     = DiapersPeriod.unfilled_categories
    @categories_with_periods = DiapersPeriod.categories_with_periods
  end

  def destroy_category
    @category = Category.find(params[:category_id])

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
end
