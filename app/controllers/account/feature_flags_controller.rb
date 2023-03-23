class Account::FeatureFlagsController < Account::BaseController
  def update
    Account::UpdateFeatureFlagsService.new(params).call
    redirect_to edit_account_site_setting_path, notice: t("notifications.feature_flags_updated")
  end
end
