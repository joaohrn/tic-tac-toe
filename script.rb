class Player
  def initialize(mark)
    @mark = mark
  end

  attr_reader :mark
end

class TicTacToe
  WINNING_POSITIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
    [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]
  ].freeze
  def initialize
    @board = Array.new(9) { |n| n + 1 }
    @game_is_won = false
    @game_is_drawn = false
    @x_player = Player.new('x')
    @o_player = Player.new('o')
    @player_to_go = @x_player
  end

  def display_board
    puts "\n
      #{@board[0]} |#{@board[1]} |#{@board[2]}\n
      #{@board[3]} |#{@board[4]} |#{@board[5]}\n
      #{@board[6]} |#{@board[7]} |#{@board[8]}
      \n"
  end

  def change_turn
    @player_to_go = if @player_to_go == @x_player
                      @o_player
                    else
                      @x_player
                    end
  end

  def place_mark(position)
    if @board[position] == 'x' || @board[position] == 'o'
      puts 'space occupied'
      return
    end
    begin
      @board[position] = @player_to_go.mark
      change_turn
    rescue e
      puts 'invalid board location'
    end
  end

  def draw_check
    return unless @board.none? { |position| position.is_a? Numeric }

    @game_is_drawn = true
    puts 'It\'s a draw'
    display_board
  end

  def win_check
    WINNING_POSITIONS.each do |combination|
      next if @board[combination[0]] != @board[combination[1]] || @board[combination[0]] != @board[combination[2]]

      @game_is_won = true
      display_board
      if @player_to_go == @x_player
        puts "#{@o_player.mark} player has won!"
        display_board
      else
        puts "#{@x_player.mark} player has won!"
        display_board
      end
      break
    end
  end

  def play_game
    until @game_is_drawn || @game_is_won
      display_board
      puts 'where do you wish to place your mark?'
      position = gets.chomp.to_i
      place_mark(position - 1)
      win_check
      draw_check unless @game_is_won
    end
  end
end
tic_tac_toe = TicTacToe.new
tic_tac_toe.play_game
