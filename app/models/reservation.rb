class Reservation < ActiveRecord::Base
  validates :time, presence: true
  validates :name, presence: true
  validates :seats, presence: true
  has_many :tables
end
