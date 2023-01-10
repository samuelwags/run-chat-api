# frozen_string_literal: true

class Run < ApplicationRecord
  include Recordable

  belongs_to :user
  has_many :personal_records, dependent: :destroy

  after_create :maybe_create_new_pr

  def average
    distance / time
  end

  def maybe_create_new_pr
    user_prs = user.prs
    PersonalRecord::CATEGORY_COMPARISONS.each do |key, comp_operator|
      create_pr = -> { PersonalRecord.create!(run_id: id, user_id:, category: key) }

      value = send(key)

      next if value.nil?

      record = user_prs[key]&.run&.send(key)

      if record.blank?
        create_pr.call
      else
        better_than = value.public_send(comp_operator, record)
        create_pr.call if better_than
      end
    end
  end
end
