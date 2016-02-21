class Card < ActiveRecord::Base

  attr_accessible :face, :suit, :value

  has_many :game_cards
  has_many :games, through: :game_cards

  
  # generates card
  def self.hit
    Card.find_by('value=?', rand(2...12))
  end

end
