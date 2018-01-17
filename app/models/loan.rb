class Loan < ActiveRecord::Base
  belongs_to :account
  validates :category, presence: true
  validates :amount, presence: true, length: { maximum: 8 }, numericality: { only_integer: true }
  validates :no_of_years, presence: true, length: { maximum: 2 }, numericality: { only_integer: true }
end
