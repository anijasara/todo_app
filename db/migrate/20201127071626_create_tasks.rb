class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :task_id
      t.text :name
      t.text :description
      t.string :status
      t.datetime :done_at
      t.datetime :due_at
      t.references :list, foreign_key: true

      t.timestamps
    end
  end
end
