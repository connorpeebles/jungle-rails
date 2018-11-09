class ReviewsController < ApplicationController
  before_action :check_logged_in

  def create
    @review = Review.new(review_params)
    @review.user = current_user

    @product = Product.find params[:product_id]
    @review.product = @product
    
    if @review.save
      redirect_to product_path(params[:product_id])
    else
      render 'products/show'
    end
  end

  def destroy
    @review = Review.find_by user: current_user, product: params[:product_id]
    @review.destroy
    redirect_to product_path(params[:product_id])
  end

  private

  def review_params
    params.require(:review).permit(
      :rating,
      :description
    )
  end

  def check_logged_in
    if !current_user
      redirect_to '/'
    end
  end

end
