class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all
  end

  # Fetch transactions from NearApiService and redirect to root success.
  def fetch_transactions
    begin
      result = NearApiService.instance.fetch_transactions

      if result[:success]
        redirect_to root_path, notice: result[:message]
      else
        Rails.logger.error "Transaction fetch failed: #{result[:message]}, error: #{result[:error]}"
        redirect_to root_path, alert: result[:message]
      end
    rescue StandardError => e
      Rails.logger.error "Unexpected error fetching transactions: #{e.message}"
      redirect_to root_path, alert: "An unexpected error occurred."
    end
  end
end