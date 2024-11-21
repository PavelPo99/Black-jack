require_relative "user"
require_relative "dealer"
require_relative "desk"
require_relative "round"


class Programm
	attr_accessor :players, :deck_cards, :bank

	def initialize
		@players = [User.new, Dealer.new]
		@deck_cards = Desk.new
		@bank = 0
		@round = Round(@players, @desk)
	end

	
	

	def main
		puts "Добро пожаловать, игрок!\n\nНазови себя:"
		name_player = gets.chomp

		display
		play_game

		puts "Победил #{counting_results}"

		# думаю над визуализацией игрового процесса 
	end


	private

	
end



