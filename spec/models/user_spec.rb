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

  describe '.authenticate_with_credentials' do
    subject {
      described_class.new(first_name: "First", last_name: "Last", email: "test@example.com", password: "abc", password_confirmation: "abc")
    }

    it 'returns a User if the email exists and password matches' do
      subject.save
      result = User.authenticate_with_credentials("test@example.com", "abc")
      expect(result).to be_instance_of User
    end
    it 'returns nil if the email exists but password does not match' do
      subject.save
      result = User.authenticate_with_credentials("test@example.com", "ABC")
      expect(result).to be_nil
    end
    it 'returns nil if the email does not exist' do
      result = User.authenticate_with_credentials("test@example.com", "abc")
      expect(result).to be_nil
    end
    it 'returns a User if the email exists, but different casing, and password matches' do
      subject.save
      result = User.authenticate_with_credentials("TEST@example.com", "abc")
      expect(result).to be_instance_of User
    end
    it 'returns a User if the email exists, but with spaces before the address, and password matches' do
      subject.save
      result = User.authenticate_with_credentials("  test@example.com", "abc")
      expect(result).to be_instance_of User
    end
    it 'returns a User if the email exists, but with spaces after the address, and password matches' do
      subject.save
      result = User.authenticate_with_credentials("test@example.com  ", "abc")
      expect(result).to be_instance_of User
    end
    it 'returns a User if the email exists, but with spaces before and after the address, and password matches' do
      subject.save
      result = User.authenticate_with_credentials("   test@example.com ", "abc")
      expect(result).to be_instance_of User
    end
  end

end
