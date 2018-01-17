class Transaction < ActiveRecord::Base
  belongs_to :account
  validates :number, presence: true, uniqueness: true, length: { maximum: 5 }, numericality: { only_integer: true }
  enum category: { withdraw: true, deposit: false }
  validates :category, presence: true
  validates :amount, presence: true, length: { maximum: 8 }, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
