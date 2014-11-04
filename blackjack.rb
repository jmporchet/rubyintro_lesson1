require 'pry'

#create the deck of cards
deck = {
  "Ace of Hearts"=>11, "Two of Hearts"=>2, "Three of Hearts"=>3, "Four of Hearts"=>4, "Five of Hearts"=>5, "Six of Hearts"=>6, "Seven of Hearts"=>7, "Eight of Hearts"=>8, "Nine of Hearts"=>9, "Ten of Hearts"=>10, "Jack of Hearts"=>10, "Queen of Hearts"=>10, "King of Hearts"=>10,
  "Ace of Diamonds"=>11, "Two of Diamonds"=>2, "Three of Diamonds"=>3, "Four of Diamonds"=>4, "Five of Diamonds"=>5, "Six of Diamonds"=>6, "Seven of Diamonds"=>7, "Eight of Diamonds"=>8, "Nine of Diamonds"=>9, "Ten of Diamonds"=>10, "Jack of Diamonds"=>10, "Queen of Diamonds"=>10, "King of Diamonds"=>10,
  "Ace of Clubs"=>11, "Two of Clubs"=>2, "Three of Clubs"=>3, "Four of Clubs"=>4, "Five of Clubs"=>5, "Six of Clubs"=>6, "Seven of Clubs"=>7, "Eight of Clubs"=>8, "Nine of Clubs"=>9, "Ten of Clubs"=>10, "Jack of Clubs"=>10, "Queen of Clubs"=>10, "King of Clubs"=>10,
  "Ace of Spades"=>11, "Two of Spades"=>2, "Three of Spades"=>3, "Four of Spades"=>4, "Five of Spades"=>5, "Six of Spades"=>6, "Seven of Spades"=>7, "Eight of Spades"=>8, "Nine of Spades"=>9, "Ten of Spades"=>10, "Jack of Spades"=>10, "Queen of Spades"=>10, "King of Spades"=>10 
}

player_hand = {}
dealer_hand = {}
$player = ""

THRESHOLD = 21

#deal a card
def deal_a_card(deck, name)
  #take a random card from the deck
  rand_card = Hash[deck.to_a.sample(1)]

  #remove it from the deck
  deck =  deck.select!{ |k| k != rand_card.first[0] }
  puts "#{name} was dealt a #{rand_card.keys.first}"
  rand_card
end

#calculate the hand and check if busted
#take into account the ace value
def calculate_hand(hand)
  amount = 0
  hand = hand.sort_by { |k,v| v }
  hand.each do |k,v|
    if (v == 11) && ((amount + v) > THRESHOLD)
      v = 1
    end
    amount += v
  end
  amount
end

#get the input
def hit(hand, deck, name)
  hand.merge!(deal_a_card deck, name)
end

def evaluate_winner(player_hand, dealer_hand)
  player_score = calculate_hand player_hand
  dealer_score = calculate_hand dealer_hand
  if player_score == dealer_score
    "draw"
  elsif player_score > dealer_score
    "You"
  else 
    "dealer"
  end
end

def busted?(hand)
  calculate_hand(hand) > THRESHOLD
end

puts "Enter your name:"
player = gets.chomp
hit player_hand, deck, player
hit player_hand, deck, player
player_score = calculate_hand(player_hand)
if player_score == 21
  puts "You've got a Blackjack!"
else
  puts "Your score is #{calculate_hand(player_hand)}"
end

hit dealer_hand, deck, "dealer"
hit dealer_hand, deck, "dealer"
dealer_score = calculate_hand(dealer_hand)
if dealer_score == 21
  puts "The dealer's got Blackjack!"
else
  puts "The dealer's score is #{calculate_hand(dealer_hand)}"
end

while gets.chomp == 'hit'
  hit(player_hand, deck, player)
  puts "Your score is " + calculate_hand(player_hand).to_s
  if busted?(player_hand)
    puts "You busted!"
    exit
  end
end

while ( calculate_hand(dealer_hand) < 17 )
  hit dealer_hand, deck, "dealer"
  puts "The dealer's score is " + calculate_hand(dealer_hand).to_s
  if busted? dealer_hand
    puts "The dealer was busted!"
    exit
  end
end

puts "The winner is " + evaluate_winner(player_hand, dealer_hand)

exit
