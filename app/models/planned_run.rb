# frozen_string_literal: true

class PlannedRun < ApplicationRecord
  belongs_to :user
  belongs_to :training_plan

  def completed
    Run.where(
      ['distance > ?', distance]
    ).where(
      ['date::date = ?', date.to_date]
    ).find_by(user_id:).present?
  end
end
