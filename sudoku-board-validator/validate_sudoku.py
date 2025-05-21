def validate_sudoku(board):
    # row validation
    for row in board:
        if len(row) != len(set(row)):
            return False

    # col validation
    for i in range(9):
        col = [board[j][i] for j in range(9)]
        if len(col) != len(set(col)):
            return False

    # block validation
    for row in range(0, len(board), 3):
        for col in range(0, len(board), 3):
            block = []
            for i in range(3):
                for j in range(3):
                    block.append(board[row + i][col + j])
            if len(block) != len(set(block)):
                return False

    # validate valid digits (1-9 only)
    for row in board:
        if 0 in row:
            return False

    return True
