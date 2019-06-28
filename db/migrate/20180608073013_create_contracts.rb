class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|
      t.string :name
      t.timestamps
    end

    create_join_table :contracts, :users do |t|
      t.index [:contract_id, :user_id]
      t.index [:user_id, :contract_id]
    end
  end
end
