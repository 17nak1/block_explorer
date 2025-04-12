class Action < ApplicationRecord
  belongs_to :parent_transaction, class_name: 'Transaction', foreign_key: 'transaction_id'
  serialize :data, coder: JSON

  before_save :extract_deposit

  private

  # Extracts the 'deposit' value from the 'data' hash if the action is a "Transfer" and
  # save it in the 'transfer_deposit' attribute. Saving this value allows for easier and
  # less computationally expensive access later, avoiding repeated parsing of the 'data' hash.
  def extract_deposit
    if action_type == "Transfer" && data.is_a?(Hash) && data["deposit"]
      self.transfer_deposit = data["deposit"]
    end
  end
end