require_relative "player"

class User < Player
	def initialize
		@skip_move_count = 0
		super
	end

	def move_player
		puts "1. Открыть карты"
		puts "2. Пропустить ход" if @skip_move_count < 2
		puts "3. Взять карту" if @card.length < 3 
	
		choice = gets.chomp.to_i
		
		@skip_move_count += 1 if choice == 2
		hash_move = { 1 => :open_card, 2 => :skip, 3 => :take_card}
  		hash_move[choice]
	end
end
