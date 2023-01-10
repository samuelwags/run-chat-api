# frozen_string_literal: true

class PersonalRecord < ApplicationRecord
  CATEGORY_COMPARISONS = {
    distance: :>,
    split: :<,
    average: :<
  }.freeze

  belongs_to :user
  belongs_to :run

  validates :category, inclusion: { in: CATEGORY_COMPARISONS.keys.map(&:to_s) }
end
