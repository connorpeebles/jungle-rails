require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    subject {
      described_class.new(first_name: "First", last_name: "Last", email: "test@example.com", password: "abc", password_confirmation: "abc")
    }

    it 'is valid with attributes first_name, last_name, email, password, and password_confirmation' do
      expect(subject).to be_valid
    end
    it 'is not valid without a first_name' do
      subject.first_name = nil
      expect(subject).to_not be_valid
    end
    it 'is not valid without a last_name' do
      subject.last_name = nil
      expect(subject).to_not be_valid
    end
    it 'is not valid without an email' do
      subject.email = nil
      expect(subject).to_not be_valid
    end
    it 'is not valid without a password' do
      subject.password = nil
      expect(subject).to_not be_valid
    end
    it 'is not valid without a password_confirmation' do
      subject.password_confirmation = nil
      expect(subject).to_not be_valid
    end
    it 'is not valid if password_confirmation does not match password' do
      subject.password_confirmation = "ABC"
      expect(subject).to_not be_valid
    end
    it 'is not valid if email already in database' do
      exUser = User.new(first_name: "exFirst", last_name: "exLast", email: "test@example.com", password: "abc", password_confirmation: "abc")
      exUser.save
      expect(subject).to_not be_valid
    end
    it 'is not valid if email already in database, but different casing' do
      exUser = User.new(first_name: "exFirst", last_name: "exLast", email: "TEST@example.com", password: "abc", password_confirmation: "abc")
      exUser.save
      expect(subject).to_not be_valid
    end
    it 'is not valid if password is less than 3 characters' do
      subject.password = "ab"
      subject.password_confirmation = "ab"
      expect(subject).to_not be_valid
    end
  end

end
