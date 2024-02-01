# frozen_string_literal: true

class Account::SiteSettingsController < Account::BaseController
  load_and_authorize_resource

  def edit
    @site_setting = resource
    @categories = Category.joins(:diapers_periods).distinct
  end

  def show_all_categories
    @categories = Category.left_outer_joins(:diapers_periods).where(diapers_periods: { category_id: nil }).distinct
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def show_diapers_categories
    @categories = Category.joins(:diapers_periods).distinct
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def show_diapers_period
    @category = Category.find(params[:category_id])
    @diapers_periods = DiapersPeriod.where(category_id: params[:category_id])

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def edit_diapers_period
    @diapers_period = DiapersPeriod.find(params[:id])
  end

  def delete_all_periods
    category = Category.find(params[:category_id])
    category.diapers_periods.destroy_all
    redirect_to account_site_setting_path, notice: 'All periods for this category were successfully deleted.'
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def update
    @site_setting = resource

    if @site_setting.update(site_setting_params)
      redirect_to edit_account_site_setting_path, notice: t("notifications.site_setting_updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def revert
    @site_setting = resource

    @site_setting.update(title: "ZeroWaste", favicon: {
      io: File.open("app/assets/images/icons/favicon-48x48.png"),
      filename: "favicon-48x48.png",
      content_type: "image/png"
    })

    redirect_to edit_account_site_setting_path, notice: t("notifications.site_setting_reverted")
  end

  private

  def resource
    SiteSetting.current
  end

  def site_setting_params
    params.require(:site_setting).permit(:title, :favicon)
  end
end
