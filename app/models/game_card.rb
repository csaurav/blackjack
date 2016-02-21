class GameCard < ActiveRecord::Base

  belongs_to :game
  belongs_to :card
  belongs_to :user


  def self.collection(game_id)
    where(game_id: game_id)
  end
end
