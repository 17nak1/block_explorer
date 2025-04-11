class UpdateTxTimeAndApiIdDataTypesInTransactions < ActiveRecord::Migration[7.2]
  def change
    change_column :transactions, :tx_time, :string
    change_column :transactions, :api_id, :integer
  end
end
