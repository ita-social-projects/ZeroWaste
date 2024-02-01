class Account::DiapersPeriodsController < Account::BaseController
  # repond_with format: :turbo_stream, only: []

  def available_categories
    @categories = Category.available_categories
  end

  def index
  end

  def new
    # @site_setting               = SiteSetting.current
    @diapers_period             = DiapersPeriod.new(category_id: params[:category_id])
    # render template: "account/site_settings/new_diapers_period"

    respond_to :turbo_stream
  end

  def edit
    @diapers_period = DiapersPeriod.find(params[:id])

    # render template: :edit_diapers_period
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
      if @diapers_period.update!(diapers_period_params)
        format.turbo_stream { redirect_back(fallback_location: account_site_setting_path, notice: "Diapers period was successfully updated.") }
        format.html { redirect_back(fallback_location: account_site_setting_path, notice: "Diapers period was successfully updated.") }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@diapers_period, partial: "account/site_settings/form_diapers_period", locals: { diapers_period: @diapers_period }) }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # Action to DESTROY ALL periods for category
  def destroy
    @category = Category.find(params[:category_id])

    # notify if something went wrong
    @category.diapers_periods.destroy_all

    respond_to :turbo_stream
  end

  # Action to DESTROY ONE period for each category
  # def destroy
  #   @diapers_period = DiapersPeriod.find(params[:id])
  #   @diapers_period.destroy

  #   respond_to do |format|
  #     format.turbo_stream { redirect_back(fallback_location: account_site_setting_path, notice: "Period was successfully destroyed.", status: :see_other) }
  #     format.html { redirect_back(fallback_location: account_site_setting_path, notice: "Period was successfully destroyed.", status: :see_other) }
  #   end
  # end

  private

  def diapers_period_params
    params.require(:diapers_period).permit(:price, :period_start, :period_end, :usage_amount, :category_id)
  end
end
