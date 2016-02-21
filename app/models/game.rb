class Game < ActiveRecord::Base

  has_many :user_games
  has_many :users, through: :user_games

  has_many :game_cards
  has_many :cards, through: :game_cards
  
  PLAYER_WON = :player_won
  PLAYER_LOST = :player_lost
  CONTINUE = :continue
  COMPARE = :compare

  def player
    users.where(is_dealer: false).first
  end

  def dealer
    users.where(is_dealer: true).first
  end
  
  def setup_users(current_user, system_user)
    users << current_user
    users << system_user
  end

  def setup_cards
    
    dealer_cards
    player_cards
  end
  
  def draw_cards(user, step = 'default')
    card = _draw_cards
    game_cards.create!(user_id: user.id, card_id: card.id, step: step)
  end

  def winner
    return player.name if g.player.id == user_id
    return dealer.name
  end

  def looser
    return dealer.name if g.player.id == user_id
    return player.name
  end

  def score(user_type)
    send(user_type.to_sym).total_value(id)
  end
  
  def dealer_score
    dealer.total_value(id)
  end

  def player_score
    player.total_value(id)
  end
  
  def check_result(user)
    result = {}
    result[:show] = false
    result[:value] = user.is_player? ? _compare_player_result(user) : _compare_dealer_result(user) 
    return result if result[:value] == CONTINUE
    result[:value] = compare_score(dealer.total_value(id), player.total_value(id)) if result[:value] == COMPARE 
    if result[:value] == PLAYER_WON
      result[:show] = true

      write_values('player', 'dealer')
    
    elsif result[:value] == PLAYER_LOST
      result[:show] = true
      write_values('dealer', 'player')
    end
    return result
  end

  def black_jack?(value)
    value == 21
  end

  def greater_then_21?(value)
    value > 21
  end

  def lesser_then_21?(value)
    value < 21
  end

  def lesser_then_eq_16?(value)
    value <= 16
  end

  def greater_then_eq_17?(value)
    value >= 17
  end

  def compare_score(dealer_value, player_value)
    return PLAYER_LOST if dealer_value > player_value
    return PLAYER_WON
  end

  private

    def write_values(winner, looser)
      player_id = self.send(winner.to_sym).id
      winner_score = self.send(winner.to_sym).total_value(self.id)
      looser_score = self.send(looser.to_sym).total_value(self.id)
      self.update_attributes(user_id: player_id, winner_score: winner_score, looser_score: looser_score)
    end

    def _draw_cards
      Card.hit
    end

    def _compare_player_result(player)
      total_score = player.total_value(id)
      return PLAYER_WON if black_jack?(total_score)
    
      if greater_then_21?(total_score)
        return PLAYER_LOST
      else
        return CONTINUE
      end

    end

    def _compare_dealer_result(dealer)
      total_score = dealer.total_value(id)
      return PLAYER_LOST if black_jack?(total_score)
      if greater_then_eq_17?(total_score) && total_score < 21
        return COMPARE 
      elsif greater_then_21?(total_score)
        return PLAYER_WON
      elsif lesser_then_eq_16?(total_score)
         #draw_cards(dealer)
         #check_result(dealer)
         return CONTINUE
      end
    end

end
