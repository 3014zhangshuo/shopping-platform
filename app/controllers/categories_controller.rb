class CategoriesController < ApplicationController
  def show
    fetch_home_data
    @category = Category.find(params[:id])
    @products = @category.products.onshelf.paginate(page: params[:page], per_page: 10)
      .order(id: :desc).includes(:main_product_image)
  end
end
