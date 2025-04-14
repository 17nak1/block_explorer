class TransactionsController < ApplicationController
  # Eager Loading: Load all successful transactions with Transfer type in just a few queries for better performance.
  def index
    @transactions = Transaction.includes(actions: :transfer).where(success: true)
  end

  # Fetch transactions from NearApiService and redirect to root success.
  def fetch_transactions
    begin
      result = NearApiService.instance.fetch_transactions

      if result[:success]
        redirect_to root_path, notice: result[:message]
      else
        Rails.logger.error "\e[31mTransaction fetch failed: #{result[:message]}, error: #{result[:error]}\e[0m"
        redirect_to root_path, alert: result[:message]
      end
    rescue => e
      Rails.logger.error "\e[31mUnexpected error fetching transactions: #{e.message}\e[0m"
      redirect_to root_path, alert: "An unexpected error occurred."
    end
  end
end