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
    change_attributes
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

  def change_attributes
    @product.assign_attributes(products_params)
    return unless @product.valid?
    products_params[:prices_attributes].each do |key, value|
      # k = 0
      # v = {id: num, sum: sum_num}
      if value[:sum].nil?
        @product.prices.find(value[:id]).destroy
      end
    end
  end

  def products_params
    params.require(:product).permit(:title,
                                    prices_attributes: [:id, :sum, :category_id])
  end
end
