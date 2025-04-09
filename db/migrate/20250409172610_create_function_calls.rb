class CreateFunctionCalls < ActiveRecord::Migration[7.2]
  def change
    create_table :function_calls do |t|
      t.string :gas
      t.string :deposit
      t.string :method_name
      t.references :action, foreign_key: true
      t.timestamps
    end
  end
end
