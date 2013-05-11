class RenameDisplayOrderOnTheme < ActiveRecord::Migration
  def change
    rename_column :themes, :displayOrder, :display_order
  end
end
