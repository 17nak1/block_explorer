class CreateTransfers < ActiveRecord::Migration[7.2]
  def change
    create_table :transfers do |t|
      t.references :action, null: false, foreign_key: true
      t.string :deposit

      t.timestamps
    end
  end
end
