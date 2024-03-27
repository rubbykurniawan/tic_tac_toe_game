class TicTacToeBoardsController < ApplicationController
  before_action :set_tic_tac_toe_board, only: %i[ show edit update destroy get_table ]

  # GET /tic_tac_toe_boards or /tic_tac_toe_boards.json
  def index
    @tic_tac_toe_boards = TicTacToeBoard.all
  end

  # GET /tic_tac_toe_boards/1 or /tic_tac_toe_boards/1.json
  def show
    @player1 = @tic_tac_toe_board&.tic_tac_toe_players&.first&.user&.username
    @player2 = @tic_tac_toe_board&.tic_tac_toe_players&.last&.user&.username
    @turn_on_play = @tic_tac_toe_board&.tic_tac_toe_players.where("tic_tac_toe_players.is_active is true")&.first
    @initial = @turn_on_play&.initial
    @initial = @initial.present? ? @initial : 'X'
    @user_turn_on_play = @turn_on_play&.user&.username
    @the_winners = @tic_tac_toe_board&.tic_tac_toe_players&.where("tic_tac_toe_players.is_winners = ?", true)&.first&.user&.username || "-"
  end

  # GET /tic_tac_toe_boards/new
  def new
    @tic_tac_toe_board = TicTacToeBoard.new
  end

  # GET /tic_tac_toe_boards/1/edit
  def edit
  end

  # POST /tic_tac_toe_boards or /tic_tac_toe_boards.json
  def create
    tic_tac_toe_player = TicTacToePlayer.new
    ActiveRecord::Base.transaction do
      begin
        @tic_tac_toe_board = TicTacToeBoard.create
        params[:users].each_with_index do |user, index|
          player = index + 1
          @user = User.create(username: user[:username], player: player)
          if @user
            initial = player == 1 ? 'X' : 'O'
            tic_tac_toe_player = TicTacToePlayer.create(user_id: @user.id, tic_tac_toe_board_id: @tic_tac_toe_board.id, initial: initial)
          end
        end if @tic_tac_toe_board
        # tic_tac_toe_player.errors.add(:base, "Rollback")
        # raise ActiveRecord::Rollback
      rescue ActiveRecord::RecordNotFound => e
        tic_tac_toe_player.errors.add(:base, e)
        raise ActiveRecord::Rollback
      end
    end
    
    respond_to do |format|
      if tic_tac_toe_player.errors.present?
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tic_tac_toe_board.errors, status: :unprocessable_entity }
      else
        format.html { redirect_to tic_tac_toe_board_url(@tic_tac_toe_board), notice: "Tic tac toe board was successfully created." }
        format.json { render :show, status: :created, location: @tic_tac_toe_board }
      end
    end
  end

  # PATCH/PUT /tic_tac_toe_boards/1 or /tic_tac_toe_boards/1.json
  def update
    @tic_tac_toe_board&.tic_tac_toe_players.where("tic_tac_toe_players.is_active is true")&.first
    @tic_tac_toe_board.update(params[:location] => params[:initial])
    check_the_winners = TicTacToeBoard.where(id: @tic_tac_toe_board.id).where("
      (a1 = :initial AND a2 = :initial AND a3 = :initial) OR
      (b1 = :initial AND b2 = :initial AND b3 = :initial) OR
      (c1 = :initial AND c2 = :initial AND c3 = :initial) OR
      (a1 = :initial AND b1 = :initial AND c1 = :initial) OR
      (a2 = :initial AND b2 = :initial AND c2 = :initial) OR
      (a3 = :initial AND b3 = :initial AND c3 = :initial) OR
      (a1 = :initial AND b2 = :initial AND c3 = :initial) OR
      (c1 = :initial AND b2 = :initial AND a3 = :initial)
    ", initial: params[:initial]).exists?
    
    @the_winners = "-"
    if check_the_winners
      @tic_tac_toe_board.update(game_state: 'finished')
      @tic_tac_toe_board&.tic_tac_toe_players&.where("tic_tac_toe_players.initial = ?", params[:initial])&.first&.update(is_winners: true)
      @the_winners = @tic_tac_toe_board&.tic_tac_toe_players&.where("tic_tac_toe_players.is_winners = ?", true)&.first&.user&.username
    end

    player_active = @tic_tac_toe_board&.tic_tac_toe_players.where("tic_tac_toe_players.is_active is true")&.first
    player_non_active = @tic_tac_toe_board&.tic_tac_toe_players.where("tic_tac_toe_players.is_active is false")&.first
    player_active&.update(is_active: false)
    player_non_active&.update(is_active: true)
    
    @player1 = @tic_tac_toe_board&.tic_tac_toe_players&.first&.user&.username
    @player2 = @tic_tac_toe_board&.tic_tac_toe_players&.last&.user&.username
    @turn_on_play = @tic_tac_toe_board&.tic_tac_toe_players.where("tic_tac_toe_players.is_active is true")&.first
    @initial = @turn_on_play&.initial
    @initial = @initial.present? ? @initial : 'X'
    @user_turn_on_play = @turn_on_play&.user&.username

    respond_to do |format|
      format.js { render :get_table }
    end
  end

  # DELETE /tic_tac_toe_boards/1 or /tic_tac_toe_boards/1.json
  def destroy
    @tic_tac_toe_board.destroy

    respond_to do |format|
      format.html { redirect_to tic_tac_toe_boards_url, notice: "Tic tac toe board was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def get_table
    
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tic_tac_toe_board
      @tic_tac_toe_board = TicTacToeBoard.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tic_tac_toe_board_params
      params.fetch(:tic_tac_toe_board, {})
    end
end
