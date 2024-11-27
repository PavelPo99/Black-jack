require_relative "user"
require_relative "dealer"
require_relative "cards"
require_relative "round"
require 'byebug'

class Round

	def initialize(players)
		@players = players		
	end
	
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
	
	def counting_results
		hash_players= {}

		@players.each do |player|
			hash_players[player] = player.point.to_i
		end

		filtered_hash = hash_players.select { |key, value| value < 22 }
		max_value = filtered_hash.max_by { |key, value| value }

		hash_winner = filtered_hash.select { |key, value| max_value[1] == value }
		hash_winner
	end

	def move_players
		@players.each do |player|
			player.point_count			
	
			attempt = 0
			begin

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
				when :error	
					raise "Такого пункта не существует!" 
				end

			rescue RuntimeError => e
				puts e
				attempt += 1

				retry if attempt < 3

				puts "\nЛимит попыток превышен! Игра закончена."
				break
	    end
		end
	end
	
	def display_on_desk
		@players[1..].each do |player|
			puts "\nкарты дилера:\n" +  " __  "  * player.card.length + "\n" + "|**| " * player.card.length + "\n"  + "|__| " * player.card.length
			puts "кoшелек дилера: #{player.cash} $"		
		end

		puts "\n\nтвои карты:"
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
end

