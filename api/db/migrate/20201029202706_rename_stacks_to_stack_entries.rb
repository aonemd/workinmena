class RenameStacksToStackEntries < ActiveRecord::Migration[6.0]
  def change
    rename_table :stacks, :stack_entries
  end
end
