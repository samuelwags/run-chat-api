# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :uuid # for jwt auth

      t.date :signed_in_at

      t.string :password_digest

      t.timestamps
    end
  end
end
