require "#{Rails.root}/config/table_config"

class Reservation < ActiveRecord::Base
  validates :time, presence: true
  validates :name, presence: true
  validates :seats, presence: true
  before_validation :tables_available?, {message: "No Tables Available"}
  after_save :create_tables
  has_many :tables, dependent: :destroy

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
  def create_tables
    number_of_tables = tables_needed  
    number_of_tables.times { |x| Table.create(time: 1, size: 4, reservation_id: self.id) }
  end

end
