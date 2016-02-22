class AddIndex < ActiveRecord::Migration
  def change
    add_index :users, :email, unique: true
    add_index :games, :user_id

    add_index :game_cards, [:game_id, :card_id, :user_id]
    add_index :user_games, [:game_id, :user_id]
    
  end
end
