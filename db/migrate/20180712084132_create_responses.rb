class CreateResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :responses do |t|
      t.integer :statement_id
      t.string :text
      t.string :timestamp
      t.timestamps
    end
  end
end
