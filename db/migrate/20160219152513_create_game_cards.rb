class CreateGameCards < ActiveRecord::Migration
  def change
    create_table :game_cards do |t|
      t.references :game
      t.references :card
      t.references :user
      t.string     :step
      t.timestamps
    end
  end
end
