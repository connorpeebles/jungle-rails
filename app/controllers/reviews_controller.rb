class ReviewsController < ApplicationController

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

  private

  def review_params
    params.require(:review).permit(
      :rating,
      :description
    )
  end

end
