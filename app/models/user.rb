class User < ApplicationRecord
  # Regex
  EMAIL_REGEX = /[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+/.freeze

  # Validations
  validates :first_name, :last_name, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false }

  # Associations
  has_many :tasks, foreign_key: 'created_by_id', dependent: :destroy

  # Callbacks
  before_create :add_token
  has_secure_password

  def add_token
    self.access_token = create_token
  end

  def create_token
    random_token = SecureRandom.urlsafe_base64
    Digest::SHA1.hexdigest(random_token.to_s)
  end

  def change_token
    update_attribute(:access_token, create_token)
  end
end
