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
    @@grid = {
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
      # p "pos = #{pos}"
      case pos
      when '1'
        x = 0
      when '2'
        x = 2
      when '3'
        x = 4
      else
        y = pos.to_sym
      end
      # p "x = #{x}"
      # p "y = #{y}"
    end
    p @@grid
    @@grid[y][x] = symbol
    p @@grid
  end

  def display
    puts
    @@grid.each { |_row, column| puts column.join }
    puts
  end

  def grid_example
    puts
    puts
  end
end

play = true
cpt = 0

grid = Grid.new

while play == true
  cpt += 1
  if Player.total_number_of_player < 2
    puts 'Please enter the name for player X :'
    p1 = Player.new(gets, 'X')
    puts 'Please enter the name for player O :'
    p2 = Player.new(gets, 'O')
  end
  if cpt.odd?
    puts 'Player X, please play your turn'
    grid.add_symbol(gets.chomp, p1.symbol)
  elsif cpt.even?
    puts 'Player O, please play your turn'
    grid.add_symbol(gets.chomp, p2.symbol)
  end
  grid.display
end

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
