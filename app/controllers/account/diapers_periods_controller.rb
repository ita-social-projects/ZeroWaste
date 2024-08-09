class Account::DiapersPeriodsController < Account::BaseController
  def index
    @category            = category_resource
    @unfilled_categories = category_collection.with_unfilled_diapers_periods
    @diapers_periods     = @category.diapers_periods.ordered
  end

  def new
    @category       = category_resource
    @period_start   = DiapersPeriod.start_date(@category)
    @diapers_period = DiapersPeriod.new(category_id: @category.id, period_start: @period_start)
  end

  def edit
    @diapers_period = DiapersPeriod.find(params[:id])
  end

  def create
    @category            = Category.find(params[:diapers_period][:category_id])
    @unfilled_categories = category_collection.with_unfilled_diapers_periods
    @diapers_period      = @category.diapers_periods.build(diapers_period_params)
    @diapers_periods     = @category.diapers_periods.ordered

    if @diapers_period.save
      respond_to :turbo_stream
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @category            = Category.find(params[:diapers_period][:category_id])
    @unfilled_categories = category_collection.with_unfilled_diapers_periods
    @diapers_period      = DiapersPeriod.find(params[:id])
    @diapers_periods     = @category.diapers_periods.ordered

    if @diapers_period.update(diapers_period_params)
      respond_to :turbo_stream
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @diapers_period      = DiapersPeriod.find(params[:id])
    @category            = @diapers_period.category
    @unfilled_categories = category_collection.with_unfilled_diapers_periods
    @diapers_periods     = @category.diapers_periods.ordered

    if @diapers_period.destroy
      render formats: :turbo_stream, status: :see_other
    else
      render :index, formats: :turbo_stream, status: :unprocessable_entity
    end
  end

  private

  def category_collection
    Category.ordered_by_name
  end

  def category_resource
    category_collection.find(params[:category_id])
  end

  def diapers_period_params
    params.require(:diapers_period).permit(:price, :period_start, :period_end, :usage_amount, :category_id)
  end
end
