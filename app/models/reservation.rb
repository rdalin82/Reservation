require "#{Rails.root}/config/table_config"

class Reservation < ActiveRecord::Base
  validates :time, presence: true
  validates :name, presence: true
  validates :seats, presence: true
  has_many :tables

  def tables_available? 
    tables_available >= tables_needed
  end
  def tables_available 
    TableCount.four_seater - Table.where(time: self.time).count
  end
  def tables_needed
    seats = self.seats || 1
    seats/4 + seats%4
  end
  def tables_used 
    TableCount.four_seater - Table.where(time: self.time).count
  end
end
