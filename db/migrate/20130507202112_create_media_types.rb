class CreateMediaTypes < ActiveRecord::Migration
  def change
    create_table :media_types do |t|
      t.string :type
      t.string :name
      t.string :icon

      t.timestamps
    end
  end
end
