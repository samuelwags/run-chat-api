# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :user_name, presence: true, uniqueness: true
  validates :password_digest, presence: true
end
