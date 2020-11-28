class CreateTemplateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :template_lists do |t|
      t.references :template, foreign_key: true
      t.references :list, foreign_key: true

      t.timestamps
    end
  end
end
