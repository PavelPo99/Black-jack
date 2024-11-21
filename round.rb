require_relative "user"
require_relative "dealer"
require_relative "desk"
require_relative "round"

class Round

	# def initialize(players, desk)
	# 	@players = players
	# 	@deck_cards = desk

	# 	@players = [User.new, Dealer.new]
	# 	@deck_cards = Desk.new
	# end
	attr_accessor :players, :deck_cards
	def initialize
		@players = [User.new, Dealer.new]
		@deck_cards = Desk.new
	end

	def play

	end



	def move_players
		@players.each do |player|
			player.point = 0
			player.card.each { |c| player.point += points_from_suit(c)}

			

			move = player.move_player

			case move
			when :take_card
				player.card << @deck_cards.take_card
			when :skip
				next
			when :open_card
				break
			end
		end
	end

	def display
		puts "\nкарты дилера:\n" + "** " * @players[1].card.length
		puts "\nкoшелек дилера: #{@players[1].cash} $"

		puts ''

		puts "\n#{name_player.capitalize}, твои карты:\n#{@players[0].card}"
		puts "твой кoшелек: #{@players[0].cash} $"
		puts "очки: #{point_count[@players[0]]}"
	end

	def play_game
		@players.each do |player|
			break if player.cash - 10 < 0
			puts player
			player.cash -= 10
			@bank += 10

			2.times { player.card << @deck_cards.take_card }
			puts player.card
		

			loop do
				display
				move_players
			end

			counting_results

		end		
	end

	def points_from_suit(card_player)
		point_and_suit = { :"2+"=>2, :"3+"=>3, :"4+"=>4, :"5+"=>5, :"6+"=>6, :"7+"=>7, :"8+"=>8, :"9+"=>9, :"10+"=>10, :"K+"=>10, :"Q+"=>10, :"J+"=>10, :"A+"=>[1, 10], 
		:"2<3"=>2, :"3<3"=>3, :"4<3"=>4, :"5<3"=>5, :"6<3"=>6, :"7<3"=>7, :"8<3"=>8, :"9<3"=>9, :"10<3"=>10, :"K<3"=>10, :"Q<3"=>10, :"J<3"=>10, :"A<3"=>[1, 10], 
		:"2<>"=>2, :"3<>"=>3, :"4<>"=>4, :"5<>"=>5, :"6<>"=>6, :"7<>"=>7, :"8<>"=>8, :"9<>"=>9, :"10<>"=>10, :"K<>"=>10, :"Q<>"=>10, :"J<>"=>10, :"A<>"=>[1, 10], 
		:"2^"=>2, :"3^"=>3, :"4^"=>4, :"5^"=>5, :"6^"=>6, :"7^"=>7, :"8^"=>8, :"9^"=>9, :"10^"=>10, :"K^"=>10, :"Q^"=>10, :"J^"=>10, :"A^"=>[1, 10] }


		point_and_suit[:"#{card_player}"]
		# пересчитывает на очки 
	end


	def point_count
		@hash_point = {}

		@players.each do |player|
			@hash_point[player] = points_suit(player.card)
		end	
		@hash_point
	end

	def counting_results
		point_count
		puts @hash_point[@players[0]]
		puts @hash_point[@players[1]]

		@hash_point[@players[0]] > @hash_point[@players[1]] ? @players[0] : @players[1]
	end




end

