class AddActiveToTPlayer < ActiveRecord::Migration[5.2]
  def change
    add_column :tic_tac_toe_players, :is_active, :boolean, default: false
  end
end
