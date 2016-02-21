class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :suit
      t.string :face
      t.integer :value
      t.timestamps
    end
  end
end
