require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After creation' do
    before :each do
      @product1 = Product.create!(name: "product1", quantity: 10, price: 1.99, category: Category.new(name: "category1"))
      @product2 = Product.create!(name: "product2", quantity: 1, price: 100.00, category: Category.new(name: "category2"))
      @product3 = Product.create!(name: "product3", quantity: 4, price: 0.50, category: Category.new(name: "category3"))

      @item1 = LineItem.create!(product: @product1, quantity: 3, item_price_cents: 199, total_price_cents: 597)
      @item2 = LineItem.create!(product: @product2, quantity: 1, item_price_cents: 10000, total_price_cents: 10000)

      @order = Order.create!(total_cents: 10597, stripe_charge_id: "id", line_items: [@item1, @item2])

      @product1.reload
      @product2.reload
    end
    it 'deducts quantity from products based on their line item quantities' do
      expect(@product1.quantity).to eq(7)   
      expect(@product2.quantity).to eq(0)  
    end
    it 'does not deduct quantity from products that are not in the order' do
      expect(@product3.quantity).to eq(4)
    end
  end
end
