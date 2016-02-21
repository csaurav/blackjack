module StartPlayingHelper

  def show_cards(user, game_id)
    _cards_collection(user, game_id).map(&:face)
  end

  def cards_collection(user, game_id)
    _cards_collection(user, game_id)
  end

  def total_value(user, game_id)
    user.total_value(game_id)
  end

  def winner_name(game)
    User.find(game.user_id).name.upcase
  end

  private

  def _cards_collection(user, game_id)
    user.cards(game_id)
  end
end
