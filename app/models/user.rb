# frozen_string_literal: true

class User < ApplicationRecord
  include Recordable

  has_secure_password

  validates :user_name, presence: true, uniqueness: true
  validates :password_digest, presence: true

  has_many :runs
  has_many :personal_records
end
