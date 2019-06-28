class CreateEntityClouds < ActiveRecord::Migration[5.2]
  def change
    create_table :entity_clouds do |t|
      t.string :name
      t.belongs_to :statement
      t.timestamps
    end
  end
end
