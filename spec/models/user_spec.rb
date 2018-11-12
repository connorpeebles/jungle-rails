require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    subject {
      described_class.new(first_name: "First", last_name: "Last", email: "test@example.com", password: "password", password_confirmation: "password")
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
      subject.password_confirmation = "Password"
      expect(subject).to_not be_valid
    end
    it 'is not valid if email already in database' do
      exUser = User.new(first_name: "exFirst", last_name: "exLast", email: "test@example.com", password: "exPassword", password_confirmation: "exPassword")
      exUser.save
      expect(subject).to_not be_valid
    end
    it 'is not valid if email already in database, but different casing' do
      exUser = User.new(first_name: "exFirst", last_name: "exLast", email: "TEST@example.com", password: "exPassword", password_confirmation: "exPassword")
      exUser.save
      expect(subject).to_not be_valid
    end
  end

end
