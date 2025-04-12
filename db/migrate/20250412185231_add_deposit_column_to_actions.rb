class AddDepositColumnToActions < ActiveRecord::Migration[7.2]
  def change
    add_column :actions, :transfer_deposit, :string
  end
end
