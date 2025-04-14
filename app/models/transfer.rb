class Transfer < ApplicationRecord
  belongs_to :action

  validates :deposit, presence: true
end
