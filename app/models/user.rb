class User < ActiveRecord::Base

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :user_games
  has_many :games, through: :user_games

  has_many :game_cards

  scope :system_dealer, -> {where('is_dealer=?', true).first}


  def cards(game_id)
    #card_ids = game_cards_collection(game_id).pluck(:card_id)
    #Card.where(id: card_ids)
  
    game_cards_collection(game_id).collect {|game_card| game_card.card }
  end

  def total_value(game_id)
    #card_ids = game_cards_collection(game_id).pluck(:card_id)
    #Card.where(id: card_ids).pluck(:value).inject(0) {|sum, n| sum + n }
    
    card_values = game_cards_collection(game_id).collect {|game_card| game_card.card.value}
    card_values.inject(0) {|sum, n| sum + n}

  end
  
  def is_player?
    is_dealer == false
  end

  private

  def game_cards_collection(game_id)
    game_cards.where(game_id: game_id)
  end


end
