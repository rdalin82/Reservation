require "#{Rails.root}/config/table_config"

class Reservation < ActiveRecord::Base
  validates :time, presence: true
  validates :name, presence: true
  validates :seats, presence: true
  has_many :tables

  def tables_available? 
    tables_available > 0
  end
  def tables_available 
    requested_seats = self.seats/4 - self.seats % 4 
    TableCount.four_seater - Table.where(time: self.time).count - requested_seats
  end
end
