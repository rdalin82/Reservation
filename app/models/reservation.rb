class Reservation < ActiveRecord::Base
  validates :time, presence: true
  validates :name, presence: true
  validates :seats, presence: true
  validates :date, presence: true 
  validates_numericality_of :seats, greater_than: 0
  before_validation :tables_available?, {message: "No Tables Available"}
  after_save :create_tables
  has_many :tables, dependent: :destroy

  def time_display
    if self.time == 0
      "12:00am"
    elsif self.time == 12
      "12:00pm"
    elsif self.time/12 >0
      "#{self.time-12}:00pm"
    else 
      "#{self.time}:00am"
    end
  end 


  def tables_available? 
    tables_available >= tables_needed
  end
  def tables_available 
    TableCount.four_seater - Table.where(time: self.time, date: self.date).count
  end
  def tables_needed
    seats = self.seats || 1
    seats/4 + seats%4
  end
  def tables_used 
    TableCount.four_seater - Table.where(time: self.time, date: self.date).count
  end
  def create_tables
    number_of_tables = tables_needed  
    number_of_tables.times { |x| Table.create(time: self.time, date: self.date, size: 4, reservation_id: self.id) }
  end

end
