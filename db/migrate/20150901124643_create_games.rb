class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
        t.float :time_taken
        t.string :winner_id
        t.string :loser_id
        t.timestamps null:false
    end
  end
end
