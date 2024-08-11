# frozen_string_literal: true

class Account::CalculatorsController < Account::BaseController
  load_and_authorize_resource

  def index
    @q           = collection.ransack(params[:q])
    @calculators = @q.result.page(params[:page])
  end

  def show
    @calculator = resource
  end

  def new
    @products = products_collection
  end

  def edit
    @calculator = resource
    @products   = products_collection
  end

  def create
    @calculator = Calculator.new(calculator_params)

    if @calculator.save
      redirect_to account_calculators_path, notice: t("notifications.calculator_created")
    else
      @products = products_collection

      render :new, status: :unprocessable_entity
    end
  end

  def update
    @calculator = resource

    if updater
      redirect_to account_calculators_path, notice: t("notifications.calculator_updated")
    else
      @products = products_collection

      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    resource.destroy

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
    params.require(:calculator).permit(:name, :slug, :product_id)
  end

  def updater
    Calculator.transaction do
      ::Calculators::PreferableService.new(calculator_params).perform!
      @calculator.update(calculator_params)
    end
  end

  def products_collection
    Product.ordered_by_title
  end
end
