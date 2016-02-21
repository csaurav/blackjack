# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
#

@suits = %w(Clubs Diamonds Hearts Spades)
@suits.each do |suit_value|
  (2..10).to_a.each {|number| Card.create!(face: number.to_s, value: number.to_i, suit: suit_value)}
  Card.create!(face: 'Ace', value: 11, suit: suit_value)
  Card.create!(face: 'Jack', value: 10, suit: suit_value)
  Card.create!(face: 'Queen', value: 10, suit: suit_value)
  Card.create!(face: 'King', value: 10, suit: suit_value)
end


User.create!(name: 'Dealer', email: 'dealer@system.com', is_dealer: true)
User.create!(name: 'Player', email: 'player@player.com')


