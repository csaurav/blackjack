class StartPlayingController < ApplicationController
  before_filter :authorize
  before_filter :initialize_user
  before_filter :find_game, only: [:player_hit, :player_stand]
  
  
  def index
  end

  def play
    @game = Game.create
    session[:game_id] = @game.id
    @game.setup_users(current_user, @dealer)
    2.times.each { |x| @game.draw_cards(current_user) }
    @game.draw_cards(@dealer).card
    @result = @game.check_result(current_user)
    if @result[:show]
      redirect_to action: :result, id: @game.id
    else
      render :play
    end
  end

  # player has choosen to hit
  def player_hit
    find_game
    @game.draw_cards(current_user, 'hit')

    @result = @game.check_result(current_user)
    if @result[:show] 
      redirect_to action: :result, id: @game.id
    else
      render :play 
    end
  end

  def player_stand
    find_game
    @game.draw_cards(@dealer, :stand)
    @result = @game.check_result(@dealer)
    while @result[:value] == Game::CONTINUE
      @game.draw_cards(@dealer, 'stand')
      @result = @game.check_result(@dealer)
    end
    
    if @result[:show]
     # @game.update_attributes(user_id: @result[:user_id])
      redirect_to action: :result, id: @game.id
    else
      render :play 
    end
  end

  def result
    @game = Game.find(params[:id])
  end

  def statistics
    @users = []
    @dealers_score = []
    @players_score = []
    @table_headers = []
    @games = current_user.games
    @users << User.system_dealer.name << current_user.name

    @games.each_with_index do |game, index|
      @table_headers << "Game #{index+1}"
      @dealers_score << game.dealer.total_value(game.id)
      @players_score << game.player.total_value(game.id)
    end
  end


  private

  def initialize_user
    @dealer ||= User.system_dealer
  end

  def find_game
    @game = Game.find(session[:game_id]) if session[:game_id].present?
    @game ||= Game.create
    session[:game_id] = @game.id
    
  end
end
