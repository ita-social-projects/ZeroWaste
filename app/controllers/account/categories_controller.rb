# frozen_string_literal: true

class Account::CategoriesController < Account::BaseController
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

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
    params.require(:category).permit(:name, :priority)
  end

  def render_404
    render 'errors/admin_404', status: :not_found, layout: 'account'
  end
end
