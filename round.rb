require_relative "user"
require_relative "dealer"
require_relative "desk"
require_relative "round"
require 'byebug'

class Round
	attr_accessor :players, :deck_cards
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



	def move_players
		@players.each do |player|
			point_count			
			move = player.move_player

			case move
			when :take_card
				point_count
				player.card << @deck_cards.take_card
			when :skip
				point_count
				next
			when :open_card
				point_count
				break
			end
		end
	end

	
	def display_on_desk
		point_count
		puts "\nкарты дилера:\n" + "** " * @players[1].card.length
		# puts "\дилера карты:\n#{@players[1].card}"   #{name_player.capitalize},
		# puts "очки: #{@players[1].point}"
		puts "\nкoшелек дилера: #{@players[1].cash} $"

		puts ''

		puts "\nтвои карты:\n#{@players[0].card}"   #{name_player.capitalize},
		puts "твой кoшелек: #{@players[0].cash} $"
		puts "очки: #{@players[0].point}\n"
	end


	def begin_play	
		@deck_cards = Desk.new
		@deck_cards.shuffle_cards

		@players.each do |player| 
			player.skip_move_count = 0
			player.point = 0
			player.card.clear
			2.times { player.card << @deck_cards.take_card }	
		end	
	end

	def points_from_suit(card_player)
		point_and_suit = { :"2+"=>2, :"3+"=>3, :"4+"=>4, :"5+"=>5, :"6+"=>6, :"7+"=>7, :"8+"=>8, :"9+"=>9, :"10+"=>10, :"K+"=>10, :"Q+"=>10, :"J+"=>10, :"A+"=>[1, 11], 
		:"2<3"=>2, :"3<3"=>3, :"4<3"=>4, :"5<3"=>5, :"6<3"=>6, :"7<3"=>7, :"8<3"=>8, :"9<3"=>9, :"10<3"=>10, :"K<3"=>10, :"Q<3"=>10, :"J<3"=>10, :"A<3"=>[1, 11], 
		:"2<>"=>2, :"3<>"=>3, :"4<>"=>4, :"5<>"=>5, :"6<>"=>6, :"7<>"=>7, :"8<>"=>8, :"9<>"=>9, :"10<>"=>10, :"K<>"=>10, :"Q<>"=>10, :"J<>"=>10, :"A<>"=>[1, 11], 
		:"2^"=>2, :"3^"=>3, :"4^"=>4, :"5^"=>5, :"6^"=>6, :"7^"=>7, :"8^"=>8, :"9^"=>9, :"10^"=>10, :"K^"=>10, :"Q^"=>10, :"J^"=>10, :"A^"=>[1, 11] }

		point_and_suit[:"#{card_player}"]
	end


	def point_count
		@players.each do |player|
			player.point = 0

			player.card.each do |c|
				if c[0] == "A"
					if player.point < 11
						player.point += points_from_suit(c)[1]
					else
						player.point += points_from_suit(c)[0]
					end
				else
					player.point += points_from_suit(c)
				end
			end
		end
	end

	def counting_results
		point_count

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

