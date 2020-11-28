class CreateTemplateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :template_tasks do |t|
      t.references :template, foreign_key: true
      t.references :task, foreign_key: true

      t.timestamps
    end
  end
end
