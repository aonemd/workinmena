class CreateStacks < ActiveRecord::Migration[6.0]
  def change
    create_table :stacks do |t|
      t.references :company, foreign_key: true
      t.references :tool, foreign_key: true

      t.timestamps
    end

    add_index :stacks, [:company_id, :tool_id ], unique: true, name: 'index_stacks_on_company_and_tool'
  end
end
