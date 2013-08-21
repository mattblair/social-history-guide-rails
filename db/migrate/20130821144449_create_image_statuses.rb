class CreateImageStatuses < ActiveRecord::Migration
  def change
    create_table :image_statuses do |t|
      t.string :name
      t.string :human_name

      t.timestamps
    end
  end
end
