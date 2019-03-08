class ChangeToolColumnDefaults < ActiveRecord::Migration[6.0]
  def change
    change_column_default :tools, :description, ''
    change_column_default :tools, :website, ''
  end
end
