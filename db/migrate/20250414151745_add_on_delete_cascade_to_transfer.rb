class AddOnDeleteCascadeToTransfer < ActiveRecord::Migration[7.2]
  def change
    remove_foreign_key :transfers, :actions
    add_foreign_key :transfers, :actions, on_delete: :cascade
  end
end
