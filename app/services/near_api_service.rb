# Service to fetch and store NEAR blockchain transactions from an external NEAR blockchain API.
# Use a singleton pattern to ensure a single instance with configured API key.
class NearApiService
  class << self
    attr_accessor :instance
  end

  def initialize(api_key)
    @url = "https://4816b0d3-d97d-47c4-a02c-298a5081c0f9.mock.pstmn.io/near/transactions?api_key=#{api_key}"
  end

  # Configures the service with the API key.
  def self.setup(api_key)
    self.instance = new(api_key)
  end

  # Fetch transactions from the API and save them in dbs.
  # @return [Hash] A hash containing the result of the operation.
  #                - `:success` (Boolean): Indicates whether the operation was successful.
  #                - `:message` (String): A message describing the result.
  #                - `:error`   (String, optional): An error message if the operation failed.
  def fetch_transactions
    begin
      response = HTTParty.get(@url)
      transactions = response.parsed_response

      if response.code != 200 || transactions.blank?
        return failure_result("Failed to fetch transactions", transactions["error"])
      end

      save_transactions(transactions)
      success_result("Transactions fetched and saved!")
    rescue JSON::ParserError => e
      failure_result("JSON parsing error", e.message)
    rescue HTTParty::Error => e
      failure_result("API request failed", e.message)
    rescue => e
      Rails.logger.error "Unexpected error in fetch_transactions: #{e.message}"
      failure_result("Unexpected error", e.message)
    end
  end

  private

  # Save transaction data to the transactions and actions database.
  #
  # @param transactions [Array] An array of transaction data hashes.
  def save_transactions(transactions)
    transactions.each do |tx|
      next if Transaction.exists?(tx_hash: tx["hash"])

      begin
        new_tx = Transaction.create!(transaction_attributes(tx))
        if tx["actions"].is_a?(Array)
          save_actions(new_tx, tx["actions"]) 
        end

      rescue ActiveRecord::RecordInvalid => e
        Rails.logger.error "Failed to create transaction: #{e.message}, tx: #{tx.inspect}"
      rescue => e
        Rails.logger.error "An unexpected error occurred when saving transaction: #{e.message}, tx: #{tx.inspect}"
      end
    end
  end

  # Extract transaction attributes for database creation.
  #
  # @param tx [Hash] A hash containing transaction data.
  # @return [Hash] A hash of transaction attributes for database creation.
  def transaction_attributes(tx)
    {
      api_id: tx["id"],
      api_created_at: tx["created_at"],
      api_updated_at: tx["updated_at"],
      block_height: tx["height"],
      block_hash: tx["block_hash"],
      tx_hash: tx["hash"],
      sender: tx["sender"],
      receiver: tx["receiver"],
      success: tx["success"],
      tx_time: tx["time"],
      gas_burnt: tx["gas_burnt"],
      actions_count: tx["actions_count"],
    }
  end

  # Saves all action records associated with a transaction.
  #
  # @param transaction [Transaction] The Transaction object to associate actions with.
  # @param actions_data [Array] An array of action data hashes.
  def save_actions(transaction, actions_data)
    return unless actions_data.is_a?(Array)

    actions_data.each do |action_data|
      begin
        transaction.actions.create!(
          action_type: action_data["type"],
          data: action_data["data"]
        )
      rescue ActiveRecord::RecordInvalid => e
        Rails.logger.error "Failed to create action: #{e.message}, action: #{action_data.inspect}"
      rescue => e
        Rails.logger.error "An unexpected error occurred when saving action: #{e.message}, action: #{action_data.inspect}"
      end
    end
  end

  def success_result(message)
    { success: true, message: message }
  end

  def failure_result(message, error = nil)
    { success: false, message: message, error: error }
  end
end