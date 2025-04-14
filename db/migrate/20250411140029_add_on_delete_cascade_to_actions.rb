class AddOnDeleteCascadeToActions < ActiveRecord::Migration[7.2]
  def change
    remove_foreign_key :actions, :transactions
    add_foreign_key :actions, :transactions, on_delete: :cascade
  end
end
