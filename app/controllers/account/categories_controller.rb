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

    if updater
      @category.update(category_params)
      redirect_to account_categories_path, notice: t("notifications.category_updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category = resource
    @category.destroy

    redirect_to account_categories_path, notice: t("notifications.category_deleted")
  end

  private

  def collection
    Category.ordered_by_name
  end

  def resource
    collection.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :priority, :preferable)
  end

  def updater
    Category.transaction do
      ::Categories::PreferableService.new(category_params).perform!
      @category.update(category_params)
    end
  end
end
