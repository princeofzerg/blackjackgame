puts "Welcome to the blackjack game:"
#Initialize and shuffle the deck of cards
card_number=['2','3','4','5','6','7','8','9','10','Jack','Queen','King','Ace']
card_type=['spade','heart','club','diamond']
cards=[]
card_number.each do |x|
  card_type.each do |x1|
    cards << x + " " + x1
  end
end
cards = cards.shuffle!
#declare player and dealer score containers

player_score = [0]
dealer_score = [0]
def evaluate(card,scores)
  score = 0
  card = card.split[0...1].join(' ')
  if card.to_i.to_s == card
    score = card.to_i
  else
    if card != 'Ace'
      score = 10
    else
      if scores.inject{ |sum, n| sum + n} + 11 > 21
        score = 1
      else
        score = 11
      end
    end
  end
  return score
end
# add card value to the  total scores of either player or dealer

def addtoscores(cards,scores)
  score = evaluate(cards,scores)
  scores.push(score)
end
# retrieve the total scores of either player or dealer

def get_total_scores(scores)
  playerscore = scores.inject{ |sum, n| sum + n}
  return playerscore
end
# compare the score of dealer and player

def comparescores(player_scores,dealer_scores,stay='')
   message=" "
   if player_scores == 21 and player_scores > dealer_scores
     message = "Player hits blackjack. Player wins"
     return message
     exit
   end
   if dealer_scores == 21 and dealer_scores > player_scores
     message = "Dealer hits blackjack. Dealer wins"
     return message
     exit
   end
   if player_scores > 21
     message = "You busted. You lost!"
     return message
     exit
   end
   if dealer_scores > 21
     message = "Dealer busted. you won!"
     return message
     exit
   end
   if dealer_scores == player_scores && stay == 'stay'
     message = "Its a tie!"
     return message
     exit
   end
   if dealer_scores > player_scores && stay == 'stay'
     message = "Dealer wins"
     return message
     exit
   end
   if dealer_scores < player_scores && stay == 'stay'
     message = " Player wins"
     return message
     exit
   end
   return message
end

message = " "
puts "Welcome to the black game:"
card=cards.sample
cards.delete(card)
card2=cards.sample
cards.delete(card2)
dealer_card=cards.sample
cards.delete(dealer_card)
dealer_card2=cards.sample
cards.delete(dealer_card2)
addtoscores(card,player_score)
addtoscores(card2,player_score)
addtoscores(dealer_card2,dealer_score)
addtoscores(dealer_card,dealer_score)
player_scores=get_total_scores(player_score)
dealer_scores=get_total_scores(dealer_score)
puts "Player two cards are: #{card} and #{card2}. Total score:#{player_scores}"
puts "Dealer two cards are: #{dealer_card} and #{dealer_card2}. Total score:#{dealer_scores}"
message = comparescores(player_scores,dealer_scores)
while message == " "
  puts "Do you want to continue:press 1)Hit 2)Stay"
  choice = gets.chomp
  if choice == '1'
    card = cards.sample
    cards.delete(card)
    addtoscores(card,player_score)
    puts "Your new card is : #{card}. Your new score is :#{get_total_scores(player_score)}"
    player_scores = get_total_scores(player_score)
    message=comparescores(player_scores,dealer_scores)
  end
  if choice == '2'
    while get_total_scores(dealer_score) < 17
        dealer_card = cards.sample
        cards.delete(dealer_card)
        addtoscores(dealer_card,dealer_score)
        puts "Dealer new card value::#{dealer_card}"
        puts "Dealer new score is:#{get_total_scores(dealer_score)}"
    end
    puts "Your final score is:#{get_total_scores(player_score)}."
    puts "Dealer final score is:#{get_total_scores(dealer_score)}"
    dealer_scores = get_total_scores(dealer_score)
    message = comparescores(player_scores,dealer_scores,'stay')
  end
end
puts message
