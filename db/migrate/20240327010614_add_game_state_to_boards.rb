class AddGameStateToBoards < ActiveRecord::Migration[5.2]
  def change
    add_column :tic_tac_toe_boards, :game_state, :string, default: 'ongoing'
  end
end
