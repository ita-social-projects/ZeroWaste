class Account::DiapersPeriodsController < Account::BaseController
  before_action :set_diapers_period, only: [:edit, :update]

  def new
    @site_setting               = SiteSetting.current
    @diapers_period             = DiapersPeriod.new
    @diapers_period.category_id = params[:category_id]
    render template: "account/site_settings/new_diapers_period"

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def edit
    @diapers_period = DiapersPeriod.find(params[:id])
    render template: "account/site_settings/edit_diapers_period"
  end

  def create
    @diapers_period = DiapersPeriod.new(diapers_period_params)

    respond_to do |format|
      if @diapers_period.save
        format.turbo_stream { redirect_back(fallback_location: account_site_setting_path, notice: "New Diapers period was successfully created.", status: :see_other) }
        format.html { redirect_back(fallback_location: account_site_setting_path, notice: "New Diapers period was successfully created.") }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@diapers_period, partial: "account/site_settings/form_diapers_period", locals: { diapers_period: @diapers_period }) }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    @diapers_period = DiapersPeriod.find(params[:id])

    respond_to do |format|
      if @diapers_period.update(diapers_period_params)
        format.turbo_stream { redirect_back(fallback_location: account_site_setting_path, notice: "Diapers period was successfully updated.") }
        format.html { redirect_back(fallback_location: account_site_setting_path, notice: "Diapers period was successfully updated.") }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@diapers_period, partial: "account/site_settings/form_diapers_period", locals: { diapers_period: @diapers_period }) }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @diapers_period = DiapersPeriod.find(params[:id])
    @diapers_period.destroy

    respond_to do |format|
      format.turbo_stream { redirect_back(fallback_location: account_site_setting_path, notice: "Period was successfully destroyed.", status: :see_other) }
      format.html { redirect_back(fallback_location: account_site_setting_path, notice: "Period was successfully destroyed.", status: :see_other) }
    end
  end

  private

  def set_diapers_period
    @diapers_period = DiapersPeriod.find(params[:id])
  end

  def diapers_period_params
    params.require(:diapers_period).permit(:price, :period_start, :period_end, :usage_amount, :category_id)
  end
end
