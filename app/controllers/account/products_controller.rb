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

    Category.ordered_by_name.each do |category|
      @product.prices.build(category: category) unless @product.prices.find_by(category: category)
    end
  end

  def create
    @product = Product.new(products_params)

    if @product.save
      redirect_to account_products_path,
                  notice: t("notifications.product_created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @product = resource
    @product.assign_attributes(products_params)

    if @product.save
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
    Product.ordered_by_title
  end

  def products_params
    params.require(:product).permit(:title, prices_attributes: [:id,
      :sum, :category_id, :_destroy])
  end
end
