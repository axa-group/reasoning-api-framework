class CreateNumberRanges < ActiveRecord::Migration[5.2]
  def change
    create_table :number_ranges do |t|
      t.belongs_to :statement
      t.string :parameter
      t.string :timestamp
      t.float :from
      t.float :to
      t.timestamps
    end
  end
end
