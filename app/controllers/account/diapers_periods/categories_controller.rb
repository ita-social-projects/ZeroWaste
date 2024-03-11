class Account::DiapersPeriods::CategoriesController < Account::BaseController
  def destroy
    @category = Category.find(params[:id])

    if @category.diapers_periods.destroy_all
      render formats: :turbo_stream, status: :see_other
    else
      redirect_to account_site_setting_path, alert: t("notifications.category_diapers_period_not_deleted")
    end
  end

  def with_periods
    @unfilled_categories     = Category.with_unfilled_diapers_periods
    @categories_with_periods = Category.with_diapers_periods
  end

  def available
    @categories = Category.without_diapers_periods
  end
end
