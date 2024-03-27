class CreateTicTacToePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :tic_tac_toe_players do |t|
      t.integer :user_id
      t.integer :tic_tac_toe_board_id
      t.string :initial
      t.boolean :is_winners
      t.boolean :give_up
      t.timestamps
    end
    
    add_index :tic_tac_toe_players, :user_id
    add_index :tic_tac_toe_players, :tic_tac_toe_board_id
  end
end
