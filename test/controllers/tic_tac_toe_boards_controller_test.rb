require 'test_helper'

class TicTacToeBoardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tic_tac_toe_board = tic_tac_toe_boards(:one)
  end

  test "should get index" do
    get tic_tac_toe_boards_url
    assert_response :success
  end

  test "should get new" do
    get new_tic_tac_toe_board_url
    assert_response :success
  end

  test "should create tic_tac_toe_board" do
    assert_difference('TicTacToeBoard.count') do
      post tic_tac_toe_boards_url, params: { tic_tac_toe_board: {  } }
    end

    assert_redirected_to tic_tac_toe_board_url(TicTacToeBoard.last)
  end

  test "should show tic_tac_toe_board" do
    get tic_tac_toe_board_url(@tic_tac_toe_board)
    assert_response :success
  end

  test "should get edit" do
    get edit_tic_tac_toe_board_url(@tic_tac_toe_board)
    assert_response :success
  end

  test "should update tic_tac_toe_board" do
    patch tic_tac_toe_board_url(@tic_tac_toe_board), params: { tic_tac_toe_board: {  } }
    assert_redirected_to tic_tac_toe_board_url(@tic_tac_toe_board)
  end

  test "should destroy tic_tac_toe_board" do
    assert_difference('TicTacToeBoard.count', -1) do
      delete tic_tac_toe_board_url(@tic_tac_toe_board)
    end

    assert_redirected_to tic_tac_toe_boards_url
  end
end
