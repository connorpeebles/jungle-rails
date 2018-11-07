class Admin::CategoriesController < ApplicationController

  def index
    @categories = Category.order(name: :desc).all
  end

end
