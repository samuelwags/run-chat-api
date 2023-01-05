class CreateRuns < ActiveRecord::Migration[7.0]
  def change
    create_table :runs do |t|
      t.date :date
      t.float :distance
      t.integer :time
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
