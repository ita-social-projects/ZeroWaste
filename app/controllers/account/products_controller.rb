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

    @product.prices.build
  end

  def edit
    @product = resource

    @product.build_unsigned_categories
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to account_products_path, notice: t(".created")
    else
      @product.prices.build

      render :new, status: :unprocessable_entity
    end
  end

  def update
    @product = resource

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

  def product_params
    params.require(:product).permit(:title, :default_usage_per_day, prices_attributes: [:id,
      :sum, :category_id, :_destroy])
  end
end
