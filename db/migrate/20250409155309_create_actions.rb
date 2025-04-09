class CreateActions < ActiveRecord::Migration[7.2]
  def change
    create_table :actions do |t|
      t.string :type
      t.references :transaction, foreign_key: true
      t.timestamps
    end
  end
end
