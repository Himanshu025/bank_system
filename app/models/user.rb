class User < ActiveRecord::Base
  has_many :accounts, dependent: :destroy
  validates :name, presence: true, length: { minimum: 3 }
  validates_format_of :email, with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :phone_no, presence: true, length: { minimum: 7, maximum: 12 }
  validates :aadhar_no, presence: true, length: { is: 12 }, numericality: { only_integer: true }
end
