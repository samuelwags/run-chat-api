class CreatePersonalRecordTable < ActiveRecord::Migration[7.0]
  def change
    create_table :personal_records do |t|
      t.string :type, null: false
      t.references :user, foreign_key: true
      t.references :run, foreign_key: true

      t.timestamps
    end
  end
end
