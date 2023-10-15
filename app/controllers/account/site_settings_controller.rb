# frozen_string_literal: true

class Account::SiteSettingsController < Account::BaseController
  load_and_authorize_resource

  def edit
    @site_setting = resource
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

    begin
      @site_setting.update(title: "ZeroWaste", favicon: {
        io: File.open("app/assets/images/logo_zerowaste.png"),
        filename: "logo_zerowaste.png",
        content_type: "image/png"
      })

      flash[:notice] = t("notifications.site_setting_reverted")
    rescue Errno::ENOENT
      flash[:alert] = t("notifications.site_setting_not_reverted")
    end

    redirect_to edit_account_site_setting_path
  end

  private

  def resource
    SiteSetting.current
  end

  def site_setting_params
    params.require(:site_setting).permit(:title, :favicon)
  end
end
