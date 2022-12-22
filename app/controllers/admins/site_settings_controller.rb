# frozen_string_literal: true

class Admins::SiteSettingsController < Admins::BaseController
  def index
    @site_settings = collection
  end

  def new
    @site_setting = SiteSetting.new
  end

  def edit
    @site_setting = resource
  end

  def create
    @site_setting = SiteSetting.new(site_setting_params)

    if @site_setting.save
      redirect_to admins_site_settings_path, notice: t("notifications.site_setting_created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @site_setting = resource

    if @site_setting.update(site_setting_params)
      redirect_to admins_site_settings_path, notice: t("notifications.site_setting_updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @site_setting = resource
    if @site_setting.destroy
      redirect_to admins_site_settings_path, notice: t("notifications.site_setting_deleted")
    end
  end

  private

  def collection
    SiteSetting.all
  end

  def resource
    collection.find(params[:id])
  end

  def site_setting_params
    params.require(:site_setting).permit(:title, :favicon, :enabled)
  end
end
