class TicTacToe

  def initialize(marker1 = 'X', marker2 = 'O')
    @cells = *(1..9)
    @avail_cells = *(1..9)
    @players = [['player 1', marker1], ['player 2', marker2]] 
    @curr_player_id = 0   
    display_board    
  end

  def display_board
    @board = ''

    3.times do |i|
      @board << "#{'   |' * 3} \r\n"
      3.times do |j|
        @board << " #{ @cells[(i * 3) + (j)] } |"
      end
      @board << "\r\n #{'--+---+---+'} \r\n"
    end  
    puts @board
    game_status
  end

  def prompt_player    
    puts "#{@players[@curr_player_id][0]} turn"
    cell_num = gets.chomp.to_i
    fill_cell(cell_num)
  end

  def fill_cell(cell_num)
    if @avail_cells.include?(cell_num)
      @avail_cells.delete(cell_num)
      @cells[cell_num - 1] = @players[@curr_player_id][1]
      @curr_player_id = @curr_player_id ^ 1        
      display_board
    else
      puts "Wrong input. Try again"
      prompt_player
    end
  end

  def game_status    
    update_lines
    x = @players[0][1]
    o = @players[1][1]
    @lines = @lines.partition { |ln| ln.include?(x) && ln.include?(o) }[1]

    if @lines.empty?
      puts "It's a tie" 
    elsif winner?(x)
      puts "#{@players[0][0]} wins!" 
    elsif winner?(o)
      puts "#{@players[1][0]} wins!" 
    else 
      prompt_player       
    end
  end

  def update_lines
    @lines = [
      [@cells[0], @cells[1], @cells[2]],
      [@cells[3], @cells[4], @cells[5]],
      [@cells[6], @cells[7], @cells[8]], 
      [@cells[0], @cells[3], @cells[6]],
      [@cells[1], @cells[4], @cells[7]], 
      [@cells[2], @cells[5], @cells[8]],
      [@cells[0], @cells[4], @cells[8]], 
      [@cells[2], @cells[4], @cells[6]]]
  end

  def winner?(chr)
    @lines.each do |line|
      return true if line.all? { |e| e == chr }
    end
    return false
  end  
end

t = TicTacToe.new