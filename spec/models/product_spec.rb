require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do

    subject {
      described_class.new(name: "Product Test", quantity: 10, category: Category.new(name: "Category Test"))
    }

    it 'is valid with attributes name, price, quantity, and category' do
      subject.price = 1.99
      expect(subject).to be_valid
    end
    it 'is not valid without a name' do
      subject.price = 1.99
      subject.name = nil
      expect(subject).to_not be_valid
    end
    it 'is not valid without a price' do
      expect(subject).to_not be_valid
    end
    it 'is not valid without a quantity' do
      subject.price = 1.99
      subject.quantity = nil
      expect(subject).to_not be_valid
    end
    it 'is not valid without a category' do
      subject.price = 1.99    
      subject.category = nil
      expect(subject).to_not be_valid
    end

  end

end
