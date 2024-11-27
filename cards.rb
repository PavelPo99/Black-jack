class Cards

	CARDS = []

	def initialize
		@cards = CARDS
		generate_card
	end

	def take_card
		@cards.pop unless @cards.empty?
	end

	
	private
	
	def generate_card
		suit = ["+", "<3", "<>", "^"]
		nominal = [(2..10).to_a, "J", "Q", "K", "A"].flatten.map! {|a| a.to_s }
		
		suit.each do |s|
			nominal.each do |n|
				CARDS << n+s
			end
		end

		@cards.shuffle!
	end
end
