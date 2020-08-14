class Admin::ProductsController < Admin::BaseController
  before_action :find_root_categories, only: [:new, :create, :edit, :update]
  before_action :find_product, only: [:edit, :update, :destroy]

  def index
    @products = Product.paginate(page: params[:page], per_page: 10)
      .order("id desc")
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:notice] = "创建成功"
      redirect_to admin_products_path
    else
      render action: :new
    end
  end

  def edit
    render action: :new
  end

  def update
    @root_categories = Category.roots
    if @product.save
      flash[:notice] = "修改成功"
      redirect_to admin_products_path
    else
      render action: :new
    end
  end

  def destroy
    if @product.destroy
      flash[:notice] = "删除成功"
      redirect_to admin_products_path
    else
      flash[:notice] = "删除失败"
      redirect_to :back
    end
  end

  private

  def find_root_categories
    @root_categories = Category.roots.order(id: "desc")
  end

  def find_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit!
  end
end
