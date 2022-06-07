class Player
  attr_accessor :name, :score, :symbol

  @@number_of_player = 0

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @score = 0
    @@number_of_player += 1
  end

  def self.total_number_of_player
    @@number_of_player
  end

  def rename(name)
    self.name = name
  end

  def change_symbol(symbol)
    self.symbol = symbol
  end
end

class Grid
  def initialize
    @grid = {
      a: [' ', ' | ', ' ', ' | ', ' '],
      separator1: ['-', '-', '-', '-', '-', '-', '-', '-', '-'],
      b: [' ', ' | ', ' ', ' | ', ' '],
      separator2: ['-', '-', '-', '-', '-', '-', '-', '-', '-'],
      c: [' ', ' | ', ' ', ' | ', ' ']
    }
  end

  def add_symbol(position, symbol)
    # position au format a1 : a le nom de la liste, 1 la position
    x, y = ''
    position.split('').each do |pos|
      case pos
      when '1' then x = 0
      when '2' then x = 2
      when '3' then x = 4
      else y = pos.to_sym
      end
    end
    @grid[y][x] = symbol
  end

  def row_values
    # values_hash = @grid.select { |row, _array| row == 'a' || 'b' || 'c' }
    values_hash = {}
    @grid.each do |row, array|
      values_hash[:a] = array.join('').split(' | ') if row.to_s == 'a'
      values_hash[:b] = array.join('').split(' | ') if row.to_s == 'b'
      values_hash[:c] = array.join('').split(' | ') if row.to_s == 'c'
    end
    values_hash
  end

  def column_values
    values_hash = row_values
    column_hash = {}
    for i in 0..2 do
      column_hash["column#{i + 1}".to_sym] = []
      values_hash.each do |_row, array|
        column_hash["column#{i + 1}".to_sym] << array[i]
      end
    end
    column_hash
  end

  def diagonal_values
    values_hash = row_values
    {
      diagonal1: [values_hash['a'.to_sym][0], values_hash['b'.to_sym][1], values_hash['c'.to_sym][2]],
      diagonal2: [values_hash['a'.to_sym][2], values_hash['b'.to_sym][1], values_hash['c'.to_sym][0]]
    }
  end

  def test
    all = row_values.merge(column_values).merge(diagonal_values)
    p all
  end

  def row_win?(symbol)
    # @grid.each { |_row, array| array.all? { |tile| tile == symbol } }
    # @grid[":#{row}"].all? { |pos| pos == symbol }
  end

  def display
    puts
    @grid.each { |_row, column| puts column.join }
    puts
  end
end

play = true
cpt = 0

grid = Grid.new

grid.add_symbol('a1', 'X')
grid.add_symbol('a2', 'X')
grid.add_symbol('a3', 'X')

pp grid.row_values
pp grid.column_values
pp grid.diagonal_values

pp grid.test

# while play == true
#   cpt += 1
#   if Player.total_number_of_player < 2
#     puts 'Please enter the name for player X :'
#     p1 = Player.new(gets, 'X')
#     puts 'Please enter the name for player O :'
#     p2 = Player.new(gets, 'O')
#   end
#   if cpt.odd?
#     puts 'Player X, please play your turn'
#     grid.add_symbol(gets.chomp, p1.symbol)
#     p grid.row_win?(p1.symbol)
#     p grid.row_win?(p1.symbol)
#   elsif cpt.even?
#     puts 'Player O, please play your turn'
#     grid.add_symbol(gets.chomp, p2.symbol)
#   end
#   grid.display
# end

# player1 = Player.new('gozoo', 'X')

# puts player1.name
# puts player1.score
# player1.rename('heho')
# puts player1.name
# player2 = Player.new('richard', 'O')
# player2.score
# puts Player.total_number_of_player

# grid = Grid.new

# grid.display_grid
# grid.add_symbol('a1', 'X')
# grid.display_grid
# grid.add_symbol('b2', 'O')
# grid.display_grid
