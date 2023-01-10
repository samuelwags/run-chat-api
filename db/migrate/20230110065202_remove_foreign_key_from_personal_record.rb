class RemoveForeignKeyFromPersonalRecord < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :personal_records, :runs
  end
end
