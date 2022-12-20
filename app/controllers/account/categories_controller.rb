# frozen_string_literal: true

class Account::CategoriesController < Account::BaseController
  def index
    @categories = collection
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
      redirect_to account_categories_path, notice: "Category was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @category = resource
    if @category.update(category_params)
      redirect_to account_categories_path, notice: "Category was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category = resource
    @category.destroy

    redirect_to account_categories_path, notice: "Category was successfully destroyed."
  end

  private

  def collection
    Category.all
  end

  def resource
    collection.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
