class Account < ActiveRecord::Base
  belongs_to :user
  belongs_to :locker
  has_many :transactions, dependent: :destroy
  has_many :loans, dependent: :destroy
  validates :locker_id, presence: true, uniqueness: true
  validates :number, uniqueness: true, presence: true, length: { maximum: 8 }, numericality: { only_integer: true }
  validates :balance, presence: true, length: { maximum: 8 }, numericality: { only_integer: true }
end
