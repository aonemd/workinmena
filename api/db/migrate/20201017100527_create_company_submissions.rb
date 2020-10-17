class CreateCompanySubmissions < ActiveRecord::Migration[6.0]
  def change
    create_table :company_submissions do |t|
      t.string :name, null: false
      t.string :website, default: ''
      t.integer :tool_ids, array: true, default: []
      t.string :unknown_tools, array: true, default: []

      t.timestamps
    end
  end
end
