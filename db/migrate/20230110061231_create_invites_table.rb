class CreateInvitesTable < ActiveRecord::Migration[7.0]
  def change
    create_table :invites do |t|
      t.string :key
      t.references :user, foreign_key: true
      t.date :expires
      t.timestamps
    end
  end
end
