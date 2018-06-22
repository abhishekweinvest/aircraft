class Seat
  attr_accessor :seat_number, :row, :column, :window, :aisle, :middle, :occupied, :passenger, :aisle_last
  def initialize(seat_number, row, column, window, aisle, middle, aisle_last)
    @seat_number = seat_number
    @row = row
    @column = column
    @window = window
    @aisle = aisle
    @aisle_last = aisle_last
    @middle = middle
    @occupied = false
    @passenger = 0
  end

  def allot(passenger)
    @passenger = passenger
    @occupied = true
  end
end

class AirCraft

  attr_accessor :seats, :input, :rows, :columns, :path

  def initialize(input)
    @input = input
    @seats = []
    @rows = 0
    @path = []
    @columns = 0
    setup_seats
  end

  def info
    {seat_count: seats.count}
  end

  def available_seat
    (1..rows).each do |row|
      seat = seats.select{ |seat| seat.occupied == false && seat.row == row && seat.aisle}.first
      return seat if seat
    end
    (1..rows).each do |row|
      seat = seats.select{ |seat| seat.occupied == false && seat.row == row && seat.window}.first
      return seat if seat
    end
    (1..rows).each do |row|
      seat = seats.select{ |seat| seat.occupied == false && seat.row == row && seat.middle}.first
      return seat if seat
    end
  end

  def assign_passenger(total_passenger)
    return "Not possible" if total_passenger > seats.count
    (1..total_passenger).each do |passenger|
      seat = available_seat
      available_seat.allot(passenger) unless available_seat.nil?
    end
  end

  def setup_seats
    seat_number = 1
    input.each_with_index do |set, index|
      return if set.count < 2
      (1..set[1]).each do |row|
        (1..set[0]).each_with_index do |col, col_index|
          window = (index == 0 && col == 1) ? true : false
          window = (index == (input.count-1) && col == set[0]) ? true : false unless window
          aisle  = (!window && (col_index == 0 || col_index == (set[0]-1))) ? true : false
          aisle_last  = (!window && (col_index == (set[0]-1))) ? true : false
          middle = false
          middle = true if !aisle && !window
          seats << Seat.new(seat_number, row, columns+col, window, aisle, middle, aisle_last)
          seat_number += 1
        end
      end
      @path << columns + set[0]
      @columns = columns + set[0]
      @rows = set[1] if set[1] > rows
    end
  end

  def print_seats
    puts "Rows - #{rows} | Columns - #{columns}"
    seats.each do |seat|
      puts "Seat No - #{seat.seat_number} | Row - #{seat.row} | Col - #{seat.column} | Window - #{seat.window} | Middle - #{seat.middle} | Aisle - #{seat.aisle} | Passenger - #{seat.passenger}"
    end
  end

  def print_seat_numbers
    (1..rows).each do |row|
      r = []
      (1..columns).each do |col|
        pas = seats.select{ |seat| seat.column == col && seat.row == row }.first
        passenger = pas.nil? ? 'X' : pas.passenger
        r << passenger
        r << "--" if path.include?(col)
      end
      p r.join(' | ')
    end
  end

end

# Uncomment below to run the code as per input
# a = AirCraft.new([[3,2],[4,3],[2,3],[3,4]])
# a.assign_passenger(30)
# a.print_seats
# a.print_seat_numbers
