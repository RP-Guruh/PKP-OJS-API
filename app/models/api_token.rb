class ApiToken < ApplicationRecord
  belongs_to :api_user

  validates :token, presence: true, uniqueness: true
  before_validation :generate_token, on: :create
  encrypts :token, deterministic: true

  private

  def generate_token
    # self.token = Digest::MD5.hexdigest(SecureRandom.hex) 32 karakter
    self.token = SecureRandom.urlsafe_base64(64) # 64 karakter
  end
end
