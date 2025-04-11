class Action < ApplicationRecord
  belongs_to :parent_transaction, class_name: 'Transaction', foreign_key: 'transaction_id'
  serialize :data, coder: JSON
end