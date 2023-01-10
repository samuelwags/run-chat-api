# frozen_string_literal: true

class Run < ApplicationRecord
  include Recordable

  belongs_to :user
  has_many :personal_records

  after_create :maybe_create_new_pr

  def average
    distance / time
  end

  def maybe_create_new_pr
    user_prs = user.prs
    PersonalRecord::CATEGORY_COMPARISONS.each do |key, comp_operator|
      create_pr = -> { PersonalRecord.create!(run_id: id, user_id:, category: key) }
      record = user_prs[key]&.run&.send(key)
      create_pr.call if record.blank? || send(key).public_send(comp_operator, record)
    end
  end
end
