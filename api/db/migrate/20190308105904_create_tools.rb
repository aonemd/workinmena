class CreateTools < ActiveRecord::Migration[6.0]
  def change
    create_table :tools do |t|
      t.string :name, null: false
      t.string :description
      t.string :website

      t.timestamps
    end

    add_index :tools, :name
  end
end
