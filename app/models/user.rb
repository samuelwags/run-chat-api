# frozen_string_literal: true

class User < ApplicationRecord
  include Recordable

  has_secure_password

  validates :user_name, presence: true, uniqueness: true
  validates :password_digest, presence: true

  has_many :runs, dependent: :destroy
  has_many :personal_records, dependent: :destroy
  has_many :owned_training_plans, class_name: 'TrainingPlan', foreign_key: 'user_id'
  has_many :training_plan_memberships, foreign_key: 'member_id'
  has_many :participating_training_plans,
    class_name: 'TrainingPlan',
    through: :training_plan_memberships,
    source: :training_plan

  def training_plans
    owned_training_plans + participating_training_plans
  end
end
