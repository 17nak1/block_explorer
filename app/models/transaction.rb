class Transaction < ApplicationRecord
  has_many :actions, dependent: :destroy
end