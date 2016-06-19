class Table < ActiveRecord::Base
  belongs_to :reservation
  validates :size, presence: true 
end
