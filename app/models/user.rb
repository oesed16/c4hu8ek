class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_initialize :generate_token
  validate :validate_email

  private
    def generate_token
      self.api_token ||= SecureRandom.hex if new_record?
    end
    def validate_email
      if User.where(email: email).exists?
        errors.add(:email, :invalid)
      end
    end
end
