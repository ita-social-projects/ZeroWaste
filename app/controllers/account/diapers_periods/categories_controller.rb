class Account::DiapersPeriods::CategoriesController < Account::BaseController
  def destroy
    @category = resource

    if @category.diapers_periods.destroy_all
      render formats: :turbo_stream, status: :see_other
    else
      render :with_periods, formats: :turbo_stream, status: :unprocessable_entity
    end
  end

  def with_periods
    @unfilled_categories     = Category.with_unfilled_diapers_periods
    @categories_with_periods = collection
  end

  def available
    @categories = Category.without_diapers_periods
  end

  private

  def collection
    Category.with_diapers_periods
  end

  def resource
    collection.find(params[:id])
  end
end
