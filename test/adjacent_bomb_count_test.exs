defmodule AdjacentBombCountTest do
  use ExUnit.Case

  test "a 3x3 board with no bombs" do
    board = Board.new(3, 3).board

    board_with_updated_bomb_counts = AdjacentBombCount.set_adjacent_bomb_counts(board)

    expected_board = [
      [
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected}
      ],
      [
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected}
      ],
      [
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected}
      ]
    ]

    assert(board_with_updated_bomb_counts == expected_board)
  end

  test "a 3x3 board with one bomb in the first tile" do
    first_tile = {0, 0}

    board =
      Board.new(3, 3).board
      |> Board.replace_tile(first_tile, Tile.new(:bomb))

    board_with_bomb_counts = AdjacentBombCount.set_adjacent_bomb_counts(board)

    expected_board = [
      [
        %Tile{type: :bomb, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected}
      ],
      [
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected}
      ],
      [
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected}
      ]
    ]

    assert(board_with_bomb_counts == expected_board)
  end

  test "a 3x3 board with one bomb in the second tile" do
    second_tile = {0, 1}

    board =
      Board.new(3, 3).board
      |> Board.replace_tile(second_tile, Tile.new(:bomb))

    board_with_bomb_counts = AdjacentBombCount.set_adjacent_bomb_counts(board)

    expected_board = [
      [
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :bomb, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected}
      ],
      [
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected}
      ],
      [
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected}
      ]
    ]

    assert(board_with_bomb_counts == expected_board)
  end

  test "a 3x3 board with one bomb in the third tile" do
    third_tile = {0, 2}

    board =
      Board.new(3, 3).board
      |> Board.replace_tile(third_tile, Tile.new(:bomb))

    board_with_bomb_counts = AdjacentBombCount.set_adjacent_bomb_counts(board)

    expected_board = [
      [
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :bomb, adjacent_bomb_count: 0, state: :unselected}
      ],
      [
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected}
      ],
      [
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected}
      ]
    ]

    assert(board_with_bomb_counts == expected_board)
  end

  test "a 3x3 board with one bomb in the fourth tile" do
    fourth_tile = {1, 0}

    board =
      Board.new(3, 3).board
      |> Board.replace_tile(fourth_tile, Tile.new(:bomb))

    board_with_bomb_counts = AdjacentBombCount.set_adjacent_bomb_counts(board)

    expected_board = [
      [
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected}
      ],
      [
        %Tile{type: :bomb, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected}
      ],
      [
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected}
      ]
    ]

    assert(board_with_bomb_counts == expected_board)
  end

  test "a 3x3 board with one bomb in the fifth tile" do
    fifth_tile = {1, 1}

    board =
      Board.new(3, 3).board
      |> Board.replace_tile(fifth_tile, Tile.new(:bomb))

    board_with_bomb_counts = AdjacentBombCount.set_adjacent_bomb_counts(board)

    expected_board = [
      [
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected}
      ],
      [
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :bomb, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected}
      ],
      [
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected}
      ]
    ]

    assert(board_with_bomb_counts == expected_board)
  end

  test "a 3x3 board with one bomb in the sixth tile" do
    sixth_tile = {1, 2}

    board =
      Board.new(3, 3).board
      |> Board.replace_tile(sixth_tile, Tile.new(:bomb))

    board_with_bomb_counts = AdjacentBombCount.set_adjacent_bomb_counts(board)

    expected_board = [
      [
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected}
      ],
      [
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :bomb, adjacent_bomb_count: 0, state: :unselected}
      ],
      [
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected}
      ]
    ]

    assert(board_with_bomb_counts == expected_board)
  end

  test "a 3x3 board with one bomb in the seventh tile" do
    seventh_tile = {2, 0}

    board =
      Board.new(3, 3).board
      |> Board.replace_tile(seventh_tile, Tile.new(:bomb))

    board_with_bomb_counts = AdjacentBombCount.set_adjacent_bomb_counts(board)

    expected_board = [
      [
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected}
      ],
      [
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected}
      ],
      [
        %Tile{type: :bomb, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected}
      ]
    ]

    assert(board_with_bomb_counts == expected_board)
  end

  test "a 3x3 board with one bomb in the eighth tile" do
    eighth_tile = {2, 1}

    board =
      Board.new(3, 3).board
      |> Board.replace_tile(eighth_tile, Tile.new(:bomb))

    board_with_bomb_counts = AdjacentBombCount.set_adjacent_bomb_counts(board)

    expected_board = [
      [
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected}
      ],
      [
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected}
      ],
      [
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :bomb, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected}
      ]
    ]

    assert(board_with_bomb_counts == expected_board)
  end

  test "a 3x3 board with one bomb in the nineth tile" do
    nineth_tile = {2, 2}

    board =
      Board.new(3, 3).board
      |> Board.replace_tile(nineth_tile, Tile.new(:bomb))

    board_with_bomb_counts = AdjacentBombCount.set_adjacent_bomb_counts(board)

    expected_board = [
      [
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected}
      ],
      [
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected}
      ],
      [
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :bomb, adjacent_bomb_count: 0, state: :unselected}
      ]
    ]

    assert(board_with_bomb_counts == expected_board)
  end

  test "a 3x3 board with two bombs, in the first and second tiles" do
    first_tile = {0, 0}
    second_tile = {0, 1}

    board =
      Board.new(3, 3).board
      |> Board.replace_tile(first_tile, Tile.new(:bomb))
      |> Board.replace_tile(second_tile, Tile.new(:bomb))

    board_with_bomb_counts = AdjacentBombCount.set_adjacent_bomb_counts(board)

    expected_board = [
      [
        %Tile{type: :bomb, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :bomb, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected}
      ],
      [
        %Tile{type: :empty, adjacent_bomb_count: 2, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 2, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected}
      ],
      [
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected}
      ]
    ]

    assert(board_with_bomb_counts == expected_board)
  end

  test "a 3x3 board with two bombs, in the first and nineth tiles" do
    first_tile = {0, 0}
    nineth_tile = {2, 2}

    board =
      Board.new(3, 3).board
      |> Board.replace_tile(first_tile, Tile.new(:bomb))
      |> Board.replace_tile(nineth_tile, Tile.new(:bomb))

    board_with_bomb_counts = AdjacentBombCount.set_adjacent_bomb_counts(board)

    expected_board = [
      [
        %Tile{type: :bomb, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected}
      ],
      [
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 2, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected}
      ],
      [
        %Tile{type: :empty, adjacent_bomb_count: 0, state: :unselected},
        %Tile{type: :empty, adjacent_bomb_count: 1, state: :unselected},
        %Tile{type: :bomb, adjacent_bomb_count: 0, state: :unselected}
      ]
    ]

    assert(board_with_bomb_counts == expected_board)
  end
end