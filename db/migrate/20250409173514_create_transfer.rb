class CreateTransfer < ActiveRecord::Migration[7.2]
  def change
    create_table :transfers do |t|
      t.string :deposit
      t.references :action, foreign_key: true
      t.timestamps
    end
  end
end
