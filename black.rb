require_relative "user"
require_relative "dealer"
require_relative "cards"
require_relative "round"


class Programm
	attr_accessor :players

	def initialize
		@players = [User.new, Dealer.new]
		@bank = 0
		@round = Round.new(@players)
	end


	def main
		
		puts "Добро пожаловать, игрок!\n\nНазови себя:"
		@name_player = gets.chomp
		
		loop do
			puts "\n\nСтавка 10$"
			sleep(1)
			if bet_on_stake == nil
				puts "Деньги закончились!"
				break		
			end 
			puts "Ставки сделаны!!!\n"
			
			result(@round.play)

			puts "Сыграть еще раз?\n1. Да\n2. Хaрош, брат. Жена убьёт"
			play_again = gets.chomp.to_i
			break if play_again == 2
		end
		puts "Спасибо за игру"
	end


	private


	def result(winner)
		puts "-------------------------------------------"
		puts "карты дилера:\n"
		@players[1].card.each { |c| print   "|#{c} | "}
		puts "\nочки: #{@players[1].point}"
		puts "кoшелек дилера: #{@players[1].cash} $"

		puts ''

		puts "твои карты:"
		@players[0].card.each { |c| print   "|#{c} | "}
		puts "\nочки: #{@players[0].point}"
		puts "твой кoшелек: #{@players[0].cash} $"
		puts "-------------------------------------------"

		case winner
		when @players[0]
			bet_for_winner(@players[0], @bank)
			puts "\nПоздравляем #{@name_player}, ты крассавчик. Вот твои бабки!"	
		when @players[1]
			bet_for_winner(@players[1], @bank)
			puts "\nДиллер забирает банк!"
		when :draw
			draw_bank = @bank/2
			bet_for_winner(@players[0], draw_bank)
			bet_for_winner(@players[1], draw_bank)
			puts "\nНичья! Возвращаем деньги"
		when :no_winner
			puts "\nПобедителя нет! Шекели сгорают"	
		end

	end

	def bet_for_winner(player, money)
		player.cash += money
		@bank = 0
	end

	def bet_on_stake
		@players.each do |player|
			break if player.cash - 10 < 0
			player.cash -= 10
			@bank += 10
		end		
	end



	# def each_players(&block)
	#     @players.each(&block)
	# end
		
end



c=Programm.new
c.main