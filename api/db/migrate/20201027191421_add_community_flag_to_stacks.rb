class AddCommunityFlagToStacks < ActiveRecord::Migration[6.0]
  def change
    add_column :stacks, :community, :boolean, default: false
  end
end
