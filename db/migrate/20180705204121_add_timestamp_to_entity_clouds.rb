class AddTimestampToEntityClouds < ActiveRecord::Migration[5.2]
  def change
    add_column :entity_clouds, :timestamp, :string
  end
end
