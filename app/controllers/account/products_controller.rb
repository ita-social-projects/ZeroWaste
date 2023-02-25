class Account::ProductsController < Account::BaseController
  def index
    @products  = collection
  end

  def show
    @product = resource
  end

  def new
    @product = Product.new
  end

  def edit
    @product = resource
  end

  def create
    @product = Product.new(products_params)

    if @product.save
      redirect_to account_products_path, notice: t("notifications.product_created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @product = resource

    if @product.update(products_params)
      redirect_to account_products_path, notice: t("notifications.product_updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = resource
    @product.destroy

    redirect_to account_products_path, notice: t("notifications.product_deleted")
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
