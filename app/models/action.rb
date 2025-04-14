class Action < ApplicationRecord
  belongs_to :parent_transaction, class_name: 'Transaction', foreign_key: 'transaction_id'
  has_one :transfer, dependent: :destroy
  serialize :data, coder: JSON

  after_create :create_transfer_deposit

  private

  # Extracts the 'deposit' value from the 'data' hash if the action is a "Transfer" and
  # save it in the 'transfer' table.
  def create_transfer_deposit
    return unless action_type == "Transfer"

    create_transfer(deposit: data["deposit"])
  end
end