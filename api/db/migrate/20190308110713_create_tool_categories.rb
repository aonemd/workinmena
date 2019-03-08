class CreateToolCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :tool_categories do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :tool_categories, :name
  end
end
