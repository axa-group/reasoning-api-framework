class EnhanceConnections < ActiveRecord::Migration[5.2]
  def up
    add_column :connections, :source_type, :string
    add_column :connections, :target_type, :string
    Connection.update_all(source_type: "EntityCloud")
    Connection.update_all(target_type: "EntityCloud")
  end
  def down
    remove_column :connections, :source_type
    remove_column :connections, :target_type
  end
end
