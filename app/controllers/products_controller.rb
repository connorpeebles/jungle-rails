class ProductsController < ApplicationController

  def index
    @error = params[:error]
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
    @review = Review.new
  end

end
