# frozen_string_literal: true

class Account::CalculatorsController < Account::BaseController
  before_action :calculator, only: [:edit, :update, :destroy]
  load_and_authorize_resource

  def index
    render "shared/under_construction" unless Rails.env.local?

    @q           = collection.ransack(params[:q])
    @calculators = @q.result.page(params[:page])
  end

  def show
    # TODO: fill it
  end

  def new
    @calculator = Calculator.new

    @calculator.fields.build.categories.build
    @calculator.formulas.build
  end

  def edit
    collect_fields_for_form
  end

  def create
    @calculator = Calculator.new(calculator_params)

    if @calculator.save
      redirect_to account_calculators_path, notice: t("notifications.calculator_created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if updater
      redirect_to edit_account_calculator_path(slug: @calculator), notice: t("notifications.calculator_updated")
    else
      collect_fields_for_form

      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @calculator.destroy

    redirect_to account_calculators_path, notice: t("notifications.calculator_deleted"), status: :see_other
  end

  private

  def collection
    Calculator.ordered_by_name
  end

  def resource
    Calculator.find(params[:slug])
   end

  def calculator
    @calculator = Calculator.friendly.find(params[:slug])
  end

  def collect_fields_for_form
    @form_fields      = collect_fields_for_kind("form")
    @parameter_fields = collect_fields_for_kind("parameter")
    @result_fields    = collect_fields_for_kind("result")
  end

  def collect_fields_for_kind(kind)
    @calculator
      .fields
      .select { |field| field.kind == kind }
      .sort_by { |field| field.created_at || Time.zone.now }
  end

  def calculator_params
    params.require(:calculator).permit(
      :id, :en_name, :uk_name, 
      formulas_attributes: [:id, :expression, :en_label, :uk_label, :calculator_id, :_destroy],
      fields_attributes: [:id, :en_label, :uk_label, :var_name, :field_type, :_destroy,
      categories_attributes: [:id, :en_name, :price, :_destroy]]
    )
  end

  def updater
    Calculator.transaction do
      ::Calculators::PreferableService.new(calculator_params).perform!
      @calculator.update(calculator_params)
    end
  end
end
