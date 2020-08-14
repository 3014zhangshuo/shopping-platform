class WelcomeController < ApplicationController
  def index
    fetch_home_data
    @products = Product.onshelf.paginate(page: params[:page], per_page: 10)
      .order(id: :desc).includes(:main_product_image)
  end
end
