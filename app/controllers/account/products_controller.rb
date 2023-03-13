class Account::ProductsController < Account::BaseController
  def index
    @products = collection
  end

  def show
    @product = resource
  end

  def new
    @ordered_categories = Category.ordered_categories

    @product = Product.new

    @product.prices.build
  end

  def edit
    @product = resource
  end

  def create
    params.dig(:product, :category_ids).shift
    @product = Product.new(products_params)
    binding.pry
    params.dig(:product, :category_ids).each do |id|
      @product.prices.new(sum: params.dig(:product, :prices_attributes, :"0", :sum),
                        category: Category.find(id))
    binding.pry
    end

    if @product.save
      binding.pry
      redirect_to account_products_path,
                  notice: t("notifications.product_created")
    else
      binding.pry
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @product = resource

    if @product.update(products_params)
      redirect_to account_products_path,
                  notice: t("notifications.product_updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = resource
    @product.destroy

    redirect_to account_products_path,
                notice: t("notifications.product_deleted")
  end

  private

  def resource
    collection.find(params[:id])
  end

  def collection
    Product.all
  end

  def products_params
    params.require(:product).permit(:title)
  end
end
