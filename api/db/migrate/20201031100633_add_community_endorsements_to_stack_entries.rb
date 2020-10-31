class AddCommunityEndorsementsToStackEntries < ActiveRecord::Migration[6.0]
  def change
    add_column :stack_entries, :community_endorsements, :integer, default: 0
  end
end
