class Admin::CategoriesController < ApplicationController

  def index
    @categories = Category.order(name: :asc).all
  end

  def new
    @product = Product.new
  end

end
