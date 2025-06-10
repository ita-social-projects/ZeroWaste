# frozen_string_literal: true

class Account::CalculatorsController < Account::BaseController
  load_and_authorize_resource
  before_action :check_constructor_flipper

  def index
    @q           = collection.ransack(params[:q])
    @calculators = @q.result.page(params[:page])
  end

  def show
    @calculator = resource
    @calculator = resource
  end

  def new
    @calculator = Calculator.new

    @calculator.fields.build
    @calculator.formulas.build
  end

  def edit
    @calculator = resource
  end

  def create
    @calculator = Calculator.new(calculator_params)

    if @calculator.save
      redirect_to account_calculator_path(slug: @calculator), notice: t("notifications.calculator_created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @calculator = resource

    if updater
      redirect_to edit_account_calculator_path(slug: @calculator), notice: t("notifications.calculator_updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def duplicate
    @calculator = resource.amoeba_dup
    @calculator.original_calculator = resource

    render :new
  end

  def destroy
    @calculator = resource

    @calculator.destroy

    redirect_to account_calculators_path, notice: t("notifications.calculator_deleted"), status: :see_other
  end

  private

  def collection
    Calculator.ordered_by_name
  end

  def resource
    collection.friendly.find(params[:slug])
  end

  def calculator_params
    params.require(:calculator).permit(
      :id, :en_name, :uk_name, :color, :logo_picture, :uk_notes, :en_notes,
      formulas_attributes: [:id, :expression, :en_label, :uk_label, :calculator_id, :en_unit, :uk_unit, :priority, :formula_image, :relation, :_destroy],
      fields_attributes: [:id, :en_label, :uk_label, :var_name, :kind, :value, :_destroy,
        categories_attributes: [:id, :en_name, :uk_name, :price, :_destroy]]
    )
  end

  def updater
    Calculator.transaction do
      @calculator.update(calculator_params)
    end
  end

  def check_constructor_flipper
    return if Flipper[:constructor_status].enabled?

    raise ActionController::RoutingError, "Constructor flipper is disabled"
  end
end
