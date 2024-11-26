require_relative "user"
require_relative "dealer"
require_relative "cards"
require_relative "round"
require 'byebug'

class Round
	# attr_accessor :players

	def initialize(players)
		@players = players		
	end
	
	# def initialize
	# 	@players = [User.new, Dealer.new]
	# end

	def play
		begin_play

		loop do 
			display_on_desk

			if move_players == nil
			  break
			end 
		end

		counting_results
	end


	private

	def move_players
		@players.each do |player|
			player.point_count			
			move = player.move_player

			case move
			when :take_card
				player.card << @cards.take_card
				player.point_count
			when :skip
				player.point_count
				next
			when :open_card
				player.point_count
				break
			end
		end
	end
	
	def display_on_desk
		puts "\nкарты дилера:\n" +  " __  "  * @players[1].card.length + "\n" + "|**| " * @players[1].card.length + "\n"  + "|__| " * @players[1].card.length
		puts "кoшелек дилера: #{@players[1].cash} $"

		puts ''

		puts "\nтвои карты:"
		@players[0].card.each { |c| print   "|#{c} | "}
		puts "\nочки: #{@players[0].point}"
		puts "твой кoшелек: #{@players[0].cash} $\n"
	end


	def begin_play	
		@cards = Cards.new


		@players.each do |player| 
			player.skip_move_count = 0
			player.point = 0
			player.card.clear
			2.times { player.card << @cards.take_card }	
			player.point_count
		end	
	end


	def counting_results
		
		if (@players[1].point.to_i < @players[0].point.to_i || @players[1].point.to_i > 21) && @players[0].point.to_i < 22
			@players[0]
		elsif (@players[0].point.to_i < @players[1].point.to_i || @players[0].point.to_i > 21) && @players[1].point.to_i < 22
			@players[1]
		elsif @players[0].point.to_i == @players[1].point.to_i
			:draw
		else
			:no_winner
		end
	end
end

