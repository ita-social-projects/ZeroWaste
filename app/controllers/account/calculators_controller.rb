# frozen_string_literal: true

class Account::CalculatorsController < Account::BaseController
  before_action :products_collection, only: [:new, :edit]
  after_action :products_collection, only: [:new, :edit]
  load_and_authorize_resource

  def show
    @calculator = resourse
  end

  def edit
    @calculator = resourse
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
    @calculator = resourse

    if updater
      redirect_to edit_account_calculator_path(slug: @calculator), notice: t("notifications.calculator_updated")
    else
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
    @products = Product.ordered
  end
end
