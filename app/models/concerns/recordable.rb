# frozen_string_literal: true

module Recordable
  extend ActiveSupport::Concern

  included do
    def prs
      PersonalRecord::CATEGORY_COMPARISONS.each_with_object({}) do |c, a|
        a[c] = personal_records
          .where(category: c)
          .includes(:run)
          .order('runs.date')
          .last
      end
    end
  end
end
