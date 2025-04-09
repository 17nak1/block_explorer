class CreateBlocks < ActiveRecord::Migration[7.2]
  def change
    create_table :blocks do |t|
      t.string :block_hash, index: { unique: true }
      t.integer :height, index: { unique: true }
      t.timestamps
    end
  end
end
