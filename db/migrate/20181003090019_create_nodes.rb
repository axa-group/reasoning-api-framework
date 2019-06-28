class CreateNodes < ActiveRecord::Migration[5.2]
  def up
    create_table :nodes do |t|
      t.string :type
      t.string :name
      t.string :text
      t.string :timestamp
      t.string :parameter
      t.float :number_from
      t.float :number_to
      t.date :date_from
      t.date :date_to
      t.belongs_to :statement

      t.timestamps
    end

    result = ActiveRecord::Base.connection.exec_query("SELECT id, statement_id, name, timestamp, parameter FROM entity_clouds")

    result.to_hash.each do |row|
      n = Node.new(type: "EntityCloud", statement_id: row["statement_id"], name: row["name"], timestamp: row["timestamp"], parameter: row["parameter"])
      n.entity_list = ActsAsTaggableOn::Tagging.where(taggable_type: "EntityCloud", taggable_id: row["id"]).map{|t| t.tag.name}
      n.save
    end

    ActsAsTaggableOn::Tagging.where(taggable_type: "EntityCloud").destroy_all

    result = ActiveRecord::Base.connection.exec_query("SELECT statement_id, text, timestamp FROM responses")
    result.to_hash.each do |row|
      Node.create(type: "Response", statement_id: row["statement_id"], text: row["text"], timestamp: row["timestamp"])
    end
    
    result = ActiveRecord::Base.connection.exec_query("SELECT statement_id, number_ranges.from, number_ranges.to, parameter, timestamp FROM number_ranges")
    result.to_hash.each do |row|
      Node.create(type: "NumberRange", statement_id: row["statement_id"], number_from: row["from"], number_to: row["to"], timestamp: row["timestamp"], parameter: row["parameter"])
    end

    Connection.destroy_all

    remove_column :connections, :source_type
    remove_column :connections, :target_type

    drop_table :entity_clouds
    drop_table :responses
    drop_table :number_ranges
  end
end
