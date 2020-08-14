class Admin::CategoriesController < Admin::BaseController
  before_action :find_root_categories, only: [:new, :create, :edit, :update]
  before_action :find_category, only: [:edit, :update, :destroy]

  def index
    if params[:id].blank?
      @categories = Category.roots
    else
      @category = Category.find(params[:id])
      @categories = @category.children
    end

    @categories = @categories.paginate(page: params[:page], per_page: 10)
      .order(id: "desc")
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save!
      flash.notice = '保存成功'
      redirect_to action: :index
    else
      render :new
    end
  end

  def edit
    render action: :new
  end

  def update
    @category.attributes = category_params
    if @category.save
      flash[:notice] = "修改成功"
      redirect_to admin_categories_path
    else
      render action: :new
    end
  end

  def destroy
    if @category.destroy
      flash[:notice] = "删除成功"
      redirect_to admin_categories_path
    else
      flash[:notice] = "删除失败"
      redirect_to :back
    end
  end

  private

  def find_root_categories
    @root_categories = Category.roots.order(id: "desc")
  end

  def find_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit!
  end
end
