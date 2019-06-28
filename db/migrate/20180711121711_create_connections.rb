class CreateConnections < ActiveRecord::Migration[5.2]
  def change
    create_table :connections do |t|
      t.integer :source_id
      t.integer :target_id
      t.string :color
      t.timestamps
    end
  end
end
