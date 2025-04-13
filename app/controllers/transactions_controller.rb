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
        Rails.logger.error "\e[31mTransaction fetch failed: #{result[:message]}, error: #{result[:error]}\e[0m"
        redirect_to root_path, alert: result[:message]
      end
    rescue => e
      Rails.logger.error "\e[31mUnexpected error fetching transactions: #{e.message}\e[0m"
      redirect_to root_path, alert: "An unexpected error occurred."
    end
  end
end