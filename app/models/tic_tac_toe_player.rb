class TicTacToePlayer < ApplicationRecord
    belongs_to :tic_tac_toe_board
    belongs_to :user
end
