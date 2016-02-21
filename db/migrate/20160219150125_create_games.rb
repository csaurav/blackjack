class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string      :result
      t.integer  :user_id
      t.integer  :final_score
      t.integer  :winner_score
      t.integer  :looser_score
      t.timestamps
    end
  end
end
