class Table < ActiveRecord::Base
  belongs_to :reservation
  validates :size, presence: true 
  validates :time, presence: true
  validates :date, presence: true
end
