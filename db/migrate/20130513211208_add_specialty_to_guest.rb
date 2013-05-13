class AddSpecialtyToGuest < ActiveRecord::Migration
  def change
    add_column :guests, :display_order, :integer, :default => 50
    add_column :guests, :specialty, :text
  end
end
