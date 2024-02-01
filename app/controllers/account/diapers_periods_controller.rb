class Account::DiapersPeriodsController < Account::BaseController
  before_action :set_diapers_period, only: [:edit, :update]

  def new
    @site_setting = SiteSetting.current
    @diapers_period = DiapersPeriod.new
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

  def update
    @diapers_period = DiapersPeriod.find(params[:id])

    if @diapers_period.update(diapers_period_params)
      redirect_back(fallback_location: account_site_setting_path, notice: 'Diapers period was successfully updated.')
    else
      render plain: "An error occurred"
    end

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def create
    @diapers_period = DiapersPeriod.new(diapers_period_params)

    respond_to do |format|
      if @diapers_period.save
        format.turbo_stream { redirect_back(fallback_location: account_site_setting_path, notice: 'New Diapers period was successfully created.') }
        format.html { redirect_back(fallback_location: account_site_setting_path, notice: 'New Diapers period was successfully created.') }
      else
        puts "=" * 100
        puts @diapers_period.errors.full_messages
        format.turbo_stream { render plain: "An error occurred" }
        format.html { render plain: "An error occurred" }
      end
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
