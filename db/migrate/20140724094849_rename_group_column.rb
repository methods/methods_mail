class RenameGroupColumn < ActiveRecord::Migration
  def change
  	rename_column :contacts, :group, :group_name
  end
end
