# frozen_string_literal: true

class TrainingPlan < ApplicationRecord
  belongs_to :user
  has_many :planned_runs, dependent: :destroy
  has_many :training_plan_memberships
  has_many :members, class_name: 'User', through: :training_plan_memberships
end
