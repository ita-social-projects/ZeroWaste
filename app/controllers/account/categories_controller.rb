# frozen_string_literal: true

class Account::CategoriesController < Account::BaseController
  load_and_authorize_resource

  def index
    @q          = collection.ransack(params[:q])
    @categories = @q.result
  end

  def new
    @category = Category.new
  end

  def edit
    @category = resource
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to account_categories_path, notice: t("notifications.category_created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @category = resource

    if @category.update(category_params)
      redirect_to account_categories_path, notice: t("notifications.category_updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category = resource

    prices = Price.where(category_id: @category.id)

    if prices.any?
      products = []

      prices.each do |price|
        products << Product.where(id: price.priceable_id).pluck(:title)
      end

      redirect_to account_categories_path, alert: "#{t(".relation_error")} #{products.join(", ")}"
    else
      @category.destroy

      redirect_to account_categories_path, notice: t("notifications.category_deleted")
    end
  end

  private

  def collection
    Category.ordered_by_name
  end

  def resource
    collection.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :priority)
  end
end
