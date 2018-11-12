class User < ActiveRecord::Base
  before_validation :downcase_email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :reviews

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 3 }
  validates :password_confirmation, presence: true
  
  has_secure_password

  def self.authenticate_with_credentials(email_address, password)
    email_address.try(:downcase!)
    email_address.try(:strip!)
    user = User.find_by_email(email_address)
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end  

  private

  def downcase_email
    email.try(:downcase!)
  end

end
