class Account::ProductsController < Account::BaseController
  def index
    @products = collection
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

    categories = @product.prices.map(&:category)

    Category.ordered_by_name.each do |category|
      @product.prices.build(category: category) unless categories.include?(category)
    end
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to account_products_path,
                  notice: t(".created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @product = resource

    if @product.update(product_params)
      redirect_to account_products_path,
                  notice: t(".updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = resource
    @product.destroy

    redirect_to account_products_path,
                notice: t(".deleted")
  end

  private

  def resource
    collection.find(params[:id])
  end

  def collection
    Product.ordered_by_title
  end

  def product_params
    params.require(:product).permit(:title, prices_attributes: [:id,
      :sum, :category_id, :_destroy])
  end
end
