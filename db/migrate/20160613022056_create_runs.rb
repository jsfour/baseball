class CreateRuns < ActiveRecord::Migration
  def change
    create_table :runs do |t|
      t.integer :player_id
      t.integer :batter_id
      t.integer :game_id

      t.timestamps null: false
    end
  end
end
