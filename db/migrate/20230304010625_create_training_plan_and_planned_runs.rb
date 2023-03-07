class CreateTrainingPlanAndPlannedRuns < ActiveRecord::Migration[7.0]
  def change
    create_table :training_plans do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.integer :penalty

      t.timestamps
    end

    create_table :training_plan_memberships do |t|
      t.references :member, references: :users, foreign_key: { to_table: :users }
      t.references :training_plan, foreign_key: true

      t.timestamps
    end

    create_table :planned_runs do |t|
      t.references :training_plan, foreign_key: true
      t.references :user, foreign_key: true
      t.date :date
      t.float :distance
      t.text :description

      t.timestamps
    end

    change_column :runs, :date, :date
  end
end
