# app/models/transaction.rb
class Transaction < ApplicationRecord
  has_many :actions, dependent: :destroy
end