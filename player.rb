class Player
	
	attr_accessor :card, :cash, :point

	def initialize
		@card = []
		@cash = 100
		@point = 0
	end

	def point_count
		@point = 0

		a_cards = @card.select { |el| el.start_with?("A") }
		@card.reject! { |el| el.start_with?("A") }
		@card.concat(a_cards)

		@card.each do |sym|
			if sym[0..1] == '10' || sym[0] == "J" ||  sym[0] == "Q" ||  sym[0] == "K" 
				@point += 10
			elsif sym[0] == "A"
				if @point + 11 < 22
						@point += 11
						@point
				else
					@point += 1
					@point
				end
			else
				@point += sym[0].to_i
				@point
			end			
		end
	end
end
