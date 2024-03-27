require "application_system_test_case"

class TicTacToeBoardsTest < ApplicationSystemTestCase
  setup do
    @tic_tac_toe_board = tic_tac_toe_boards(:one)
  end

  test "visiting the index" do
    visit tic_tac_toe_boards_url
    assert_selector "h1", text: "Tic Tac Toe Boards"
  end

  test "creating a Tic tac toe board" do
    visit tic_tac_toe_boards_url
    click_on "New Tic Tac Toe Board"

    click_on "Create Tic tac toe board"

    assert_text "Tic tac toe board was successfully created"
    click_on "Back"
  end

  test "updating a Tic tac toe board" do
    visit tic_tac_toe_boards_url
    click_on "Edit", match: :first

    click_on "Update Tic tac toe board"

    assert_text "Tic tac toe board was successfully updated"
    click_on "Back"
  end

  test "destroying a Tic tac toe board" do
    visit tic_tac_toe_boards_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tic tac toe board was successfully destroyed"
  end
end
