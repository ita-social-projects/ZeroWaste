class Account::DiapersPeriodsController < Account::BaseController
  before_action :set_diapers_period, only: [:edit, :update]

  def edit
  end

  def update
    if @diapers_period.update(diapers_period_params)
      redirect_to site_setting_path, notice: 'Diapers period was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_diapers_period
    @diapers_period = DiapersPeriod.find(params[:id])
  end

  def diapers_period_params
    params.require(:diapers_period).permit(:price, :period_start, :period_end, :usage_amount)
  end
end
