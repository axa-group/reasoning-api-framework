class CreateStatements < ActiveRecord::Migration[5.2]
  def change
    create_table :statements do |t|
      t.belongs_to :contract
      t.string :name
      t.timestamps
    end
  end
end
