class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @seq = []
    @sequence_length = 1
    @game_over = false

  end

  def play
    
    until @game_over
      take_turn
    end
  
    game_over_message 
    reset_game 
  
  end

  def take_turn
      show_sequence 
      require_sequence
      
      unless  @game_over
              round_success_message
              @sequence_length += 1
      end
       
  end

  def show_sequence
      add_random_color
      @seq.each do |color|
        puts color
        sleep 2
        system("clear")
        sleep 1
      end
  end

  def require_sequence
    
    puts "Repeat the sequence"
    
    # repeat back the new sequence that was just shown to users, one color at a time
    @seq.each do |color|
      
      user_color = gets.chomp
      
      if color[0] != user_color
        @game_over = true
        break
      end
    end
    sleep 0.25
  end

  def add_random_color
    @seq = COLORS.shuffle
  end

  def round_success_message
    puts "CONGRATULATIONS!"
  end

  def game_over_message
    puts "Game over!"
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

end


s = Simon.new
s.play
