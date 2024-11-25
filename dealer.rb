require_relative "player"

class Dealer < Player
	attr_accessor :skip_move_count
	
	def initialize
		@skip_move_count = 0
		super
	end

	def move_player
		if @point <= 17 && @card.length < 3 
			:take_card
		elsif @skip_move_count < 1
			@skip_move_count += 1
			:skip
		else
			:open_card
		end			
	end
end
