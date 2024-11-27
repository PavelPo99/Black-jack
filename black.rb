require_relative "user"
require_relative "dealer"
require_relative "cards"
require_relative "round"


class Programm
	attr_accessor :players


	def initialize
		@players = [User.new]
		@bank = 0
		@round = Round.new(@players)
	end


	def main
		
		puts "Добро пожаловать, игрок!\nНазови себя:"
		@name_player = gets.chomp

		attempt = 0
		begin
			puts "Сколько игроков играют против тебя? Разрешено количество игроков от 1 до 5: "
			num_player = gets.chomp
			raise 'Такого пункта не существует!' if num_player !~ /^[1-5]$/
			
			add_players(num_player)

			loop do
				puts "\n\nСтавка 10$"
				sleep(1)
				if bet_on_stake == nil
					puts "Деньги закончились!"
					break		
				end 
				puts "Ставки сделаны!!!\n"
				
				result(@round.play)
				attempt = 0
				begin 
					puts "Сыграть еще раз?\n1. Да\n2. Хaрош, брат. Жена убьёт"
					play_again = gets.chomp
					break if play_again.to_i == 2	  
					raise 'Такого пункта не существует!' if play_again !~ /(^1$|^2$)/ 	
				rescue RuntimeError => e
					puts e
					attempt += 1

					retry if attempt < 3

					puts "\nЛимит попыток превышен! Игра закончена."
					break
				end
			end
		rescue RuntimeError => e
			puts e
			attempt += 1

			retry if attempt < 4

			puts "\nЛимит попыток превышен!"
		end	

		puts "Спасибо за игру"
	end


	private

	def add_players(num_player)
		num_player.to_i.times { @players << Dealer.new}
	end


	def result(winner)
		puts "-------------------------------------------"
		@players[1..].each do |player|
			puts "карты дилера:\n"
			player.card.each { |c| print   "|#{c} | "}
			puts "\nочки: #{player.point}"
			puts "кoшелек дилера: #{player.cash} $"	
			puts ''
		end

		puts "\nтвои карты:"
		@players[0].card.each { |c| print   "|#{c} | "}
		puts "\nочки: #{@players[0].point}"
		puts "твой кoшелек: #{@players[0].cash} $"
		puts "-------------------------------------------"

		res = winner

		if res.size == 1
			bet_for_winner(res.to_a[0][0], @bank)
			puts "\nПоздравляем #{res.to_a[0][0]}, ты крассавчик. Вот твои бабки!"	
		elsif res.size > 1
			draw_bank = @bank/res.size.to_i
			res.each do |key, value|
				bet_for_winner(key, draw_bank)			
			end

			puts "\nНичья между игроками:"
			res.each { |key, value| print "#{key.class}, "}
			puts "Возвращаем деньги"
		else
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
end



c=Programm.new
c.main