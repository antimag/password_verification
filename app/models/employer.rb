class Employer < ApplicationRecord
  GENDER = ["Male", "Female", "Other"]
  validates :password, confirmation: true, presence: true
  validates :password_confirmation, presence: true, if: :password_changed?

  def generate_password_token
    self.password_token = SecureRandom.hex(8)
    self.pwd_link_expiry_date = nil
    self.save
  end

  def password_token_valid?(reset_password_token)
    self.password_token==reset_password_token && self.pwd_link_expiry_date.blank?
  end

  def update_password_url
    ENV['BASE_URL'] + "employers/#{self.id}/password_token=#{self.password_token}"
  end
end
