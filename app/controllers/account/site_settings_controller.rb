# frozen_string_literal: true

class Account::SiteSettingsController < Account::BaseController
  load_and_authorize_resource

  def edit
    @site_setting        = resource
    @categories          = DiapersPeriod.categories_with_periods
    @unfilled_categories = DiapersPeriod.unfilled_categories
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
