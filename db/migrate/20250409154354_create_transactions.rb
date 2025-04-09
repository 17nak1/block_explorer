class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.string :tx_hash, index: { unique: true }
      t.string :sender
      t.string :receiver
      t.boolean :success
      t.datetime :tx_time
      t.string :gas_burnt # Store as string to keep the percision
      t.integer :actions_count
      t.references :block, foreign_key: true
      t.timestamps
    end
  end
end
