class Action < ApplicationRecord
  belongs_to :parent_transaction, class_name: 'Transaction', foreign_key: 'transaction_id'
  serialize :data, coder: JSON

  def deposit
    if action_type == "transfer" && data && data.is_a?(Hash)
      data["deposit"]
    else
      nil # Or some default value
    end
  end
end