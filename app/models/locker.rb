class Locker < ActiveRecord::Base
  has_one :account
  validates :section, presence: true, inclusion: { in: %w[A B C AB BC CA AC CB BA] }
  validates :number, presence: true, length: { maximum: 5 }, numericality: { only_integer: true }
end
