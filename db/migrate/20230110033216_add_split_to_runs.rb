class AddSplitToRuns < ActiveRecord::Migration[7.0]
  def change
    add_column :runs, :split, :integer
    change_column :runs, :time, :integer
  end
end
