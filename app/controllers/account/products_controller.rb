class Account::ProductsController < Account::BaseController
  def index
    @q        = collection.ransack(params[:q])
    @products = @q.result
  end

  def show
    @product = resource
  end

  def new
    @product = Product.new
    @categories = category_collection
  end

  def edit
    @product = resource
    @categories = category_collection

    @product.build_unsigned_categories
  end

  def create
    @product = Product.new(product_params)
    @categories = category_collection

    if @product.save
      redirect_to account_products_path, notice: t(".created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @product = resource
    @categories = category_collection

    if @product.update(product_params)
      redirect_to account_products_path, notice: t(".updated")
    else
      @product.build_unsigned_categories
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = resource

    if @product.destroy
      redirect_to account_products_path, notice: t(".deleted")
    else
      redirect_to account_products_path, status: :unprocessable_entity
    end
  end

  private

  def resource
    collection.find(params[:id])
  end

  def collection
    Product.ordered_by_title
  end

  def category_collection
    Category.ordered_by_name
  end

  def product_params
    params.require(:product).permit(:title, prices_attributes: [:id,
      :sum, :category_id, :_destroy])
  end
end
