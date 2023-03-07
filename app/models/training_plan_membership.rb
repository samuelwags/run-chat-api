# frozen_string_literal: true

class TrainingPlanMembership < ApplicationRecord
  belongs_to :member, class_name: 'User'
  belongs_to :training_plan
end
