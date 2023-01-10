# frozen_string_literal: true

class Invite < ApplicationRecord
  belongs_to :user, optional: true
end