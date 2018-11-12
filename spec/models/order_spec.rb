require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After creation' do
    before :each do
      # Setup at least two products with different quantities, names, etc
      @product1 = Product.create!(name: "product1", quantity: 10, price: 1.99, category: Category.new(name: "category1"))
      @product2 = Product.create!(name: "product2", quantity: 1, price: 100.00, category: Category.new(name: "category2"))
      # Setup at least one product that will NOT be in the order
      @product3 = Product.create!(name: "product3", quantity: 4, price: 0.50, category: Category.new(name: "category3"))
    end
    it 'deducts quantity from products based on their line item quantities' do
      # TODO: Implement based on hints below
      # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)
      # 2. build line items on @order
      @item1 = LineItem.create!(product: @product1, quantity: 3, item_price_cents: 199, total_price_cents: 597)
      @item2 = LineItem.create!(product: @product2, quantity: 1, item_price_cents: 10000, total_price_cents: 10000)
      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order = Order.create!(total_cents: 10597, stripe_charge_id: "id", line_items: [@item1, @item2])
      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      # 5. use RSpec expect syntax to assert their new quantity values
      expect(@product1.quantity).to eq(7)     
    end
    # pending test 2
    xit 'does not deduct quantity from products that are not in the order' do
      # TODO: Implement based on hints in previous test
    end
  end
end
