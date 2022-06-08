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

  # Need to check if position is empty first
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
      diagonal1: [values_hash['a'.to_sym][0], values_hash['b'.to_sym][1], values_hash['c'.to_sym][2]],
      diagonal2: [values_hash['a'.to_sym][2], values_hash['b'.to_sym][1], values_hash['c'.to_sym][0]]
    }
  end

  def winner?(symbol)
    all = row_values.merge(column_values).merge(diagonal_values)
    all.each do |_key, values|
      return true if values.all? { |value| value == symbol}
    end
    false
  end

  def display
    puts
    @grid.each { |_row, column| puts column.join }
    puts
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
    @grid.add_symbol(gets.chomp, player.symbol)
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

play = true

while play == true
  Game.initialize_players
  Game.play
  play = Game.replay?
end
