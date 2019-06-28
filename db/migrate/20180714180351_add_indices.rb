class AddIndices < ActiveRecord::Migration[5.2]
  def change
    add_index :connections, [:source_id, :source_type]
    add_index :connections, [:target_id, :target_type]
    add_index :connections, :color
    add_index :entity_clouds, :timestamp
    add_index :entity_clouds, :parameter
    add_index :responses, :timestamp
    add_index :responses, :statement_id
  end
end
