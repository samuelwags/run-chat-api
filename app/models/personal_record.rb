# frozen_string_literal: true

class PersonalRecord < ApplicationRecord
  belongs_to :user
  belongs_to :run

  validates :type, inclusion: { in: %w[distance split average]}
end