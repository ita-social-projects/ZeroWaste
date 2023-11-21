# frozen_string_literal: true

class Account::CalculatorsController < Account::BaseController
  load_and_authorize_resource

  def index
    @q           = collection.ransack(params[:q])
    @calculators = @q.result
  end

  def show
    @calculator = resourse
  end

  def new
    @products = products_collection
  end

  def edit
    @calculator = resourse
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
    @calculator = resourse

    if updater
      redirect_to account_calculators_path, notice: t("notifications.calculator_updated")
    else
      @products = products_collection

      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @calculator = resourse
    @calculator.destroy!

    redirect_to account_calculators_path, notice: t("notifications.calculator_deleted")
  end

  private

  def resourse
    Calculator.friendly.find(params[:slug])
  end

  def collection
    Calculator.ordered_by_name
  end

  def calculator
    @calculator = Calculator.friendly.find(params[:slug])
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
    @products = Product.ordered_by_title
  end
end
