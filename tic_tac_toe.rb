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
    # @grid = {
    #   top: [' ', ' | ', ' ', ' | ', ' '],
    #   separator1: ['-', '-', '-', '-', '-', '-', '-', '-', '-'],
    #   mid: [' ', ' | ', ' ', ' | ', ' '],
    #   separator2: ['-', '-', '-', '-', '-', '-', '-', '-', '-'],
    #   bot: [' ', ' | ', ' ', ' | ', ' ']
    # }
    @grid = {
      top: [' ', ' ', ' '],
      mid: [' ', ' ', ' '],
      bot: [' ', ' ', ' ']
    }
  end

  # def add_symbol(position, symbol)
  #   position = position.to_i
  #   @grid[:top][position] = symbol if position.between?(7, 9)
  #   @grid[:mid][position] = symbol if position.between?(4, 6)
  #   @grid[:bot][position] = symbol if position.between?(1, 3)
  # end

  # Need to check if position is empty first
  def add_symbol(position, symbol)
    case position
    when 7..9
      @grid[:top][position % 3 - 1] = symbol
    when 4..6
      @grid[:mid][position % 3 - 1] = symbol
    when 1..3
      @grid[:bot][position - 1] = symbol
    else
      'error'
    end
  end

  def row_values
    # values_hash = @grid.select { |row, _array| row == 'a' || 'b' || 'c' }
    values_hash = {}
    @grid.each do |row, array|
      values_hash[:top] = array.join('').split(' | ') if row.to_s == 'top'
      values_hash[:mid] = array.join('').split(' | ') if row.to_s == 'mid'
      values_hash[:bot] = array.join('').split(' | ') if row.to_s == 'bot'
    end
    values_hash
  end

  def column_values
    values_hash = row_values
    column_hash = {}
    [0, 1, 2].each do |i|
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
      diagonal1: [values_hash[:top][0], values_hash[:mid][1], values_hash[:bot][2]],
      diagonal2: [values_hash[:top][2], values_hash[:mid][1], values_hash[:bot][0]]
    }
  end

  def winner?(symbol)
    all = row_values.merge(column_values).merge(diagonal_values)
    all.each do |_key, values|
      return true if values.all? { |value| value == symbol }
    end
    false
  end

  def displayold
    array = Array.new(@grid.values)
    array.map do |_row, value|
      value.insert(1, ' | ')
      value.insert(3, ' | ')
    end
    array.insert(1, ['-', '-', '-', '-', '-', '-', '-', '-', '-'])
    array.insert(3, ['-', '-', '-', '-', '-', '-', '-', '-', '-'])
    puts
    array.each { |arr| puts arr.join }
    puts
  end
  
  def display
    array = Array.new(@grid.values)
    array.each do |arr|
      arr.insert(1, ' | ')
      arr.insert(3, ' | ')
    end
    pp array
    pp @grid
  end

end

class Game
  def self.initialize_players
    if Player.total_number_of_player >= 2
      puts 'Do you want to change players ? (yes / no)'
      change_players = gets.downcase.chomp
    end

    return if change_players == 'no'

    puts 'Please enter the name for player X :'
    @player1 = Player.new(gets.chomp, 'X')
    puts 'Please enter the name for player O :'
    @player2 = Player.new(gets.chomp, 'O')
  end

  def self.display_winner(player)
    return false unless @grid.winner?(player.symbol)

    @grid.display
    puts "Player #{player.name} won !"
    true
  end

  def self.play_turn(player)
    puts "Player #{player.name}, please play your turn"
    @grid.add_symbol(gets.chomp.to_i, player.symbol)
    display_winner(player)
  end

  def self.play
    @grid = Grid.new
    cpt = 0
    loop do
      cpt += 1
      stop = cpt.odd? ? play_turn(@player1) : play_turn(@player2)
      @grid.display
      break if stop == true
    end
  end

  def self.replay?
    puts 'Do you want to replay ? (yes / no)'
    gets.downcase.chomp == 'yes'
  end
end

# play = true

# while play == true
#   Game.initialize_players
#   Game.play
#   play = Game.replay?
# end

grid = Grid.new

p grid

grid.display
grid.display
grid.display

p grid