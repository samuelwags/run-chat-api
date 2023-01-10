class UpdateDateToDateTime < ActiveRecord::Migration[7.0]
  def change
    change_column :runs, :date, :datetime
  end
end
