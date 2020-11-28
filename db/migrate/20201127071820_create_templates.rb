class CreateTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :templates do |t|
      t.string :template_id
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
