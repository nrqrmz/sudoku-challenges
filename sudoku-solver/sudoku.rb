puzzle = [
  [5,3,0,0,7,0,0,0,0],
  [6,0,0,1,9,5,0,0,0],
  [0,9,8,0,0,0,0,6,0],
  [8,0,0,0,6,0,0,0,3],
  [4,0,0,8,0,3,0,0,1],
  [7,0,0,0,2,0,0,0,6],
  [0,6,0,0,0,0,2,8,0],
  [0,0,0,4,1,9,0,0,5],
  [0,0,0,0,8,0,0,7,9]]







def sudoku(puzzle)
  # copy the puzzle
  working_puzzle = puzzle.map(&:dup)

  # get number occurrences
  occurrences = (1..9).map { |n| [n, 0] }.to_h
  working_puzzle.each { |row| row.each { |n| occurrences[n] += 1 if occurrences.key?(n) } }
  occurrences = occurrences.sort_by { |_, v| -v }.to_h

  # find empty cell
  empty_row = nil
  empty_col = nil
  found = false
  working_puzzle.each_with_index do |row, i|
    row.each_with_index do |_, j|
      if working_puzzle[i][j].zero?
        empty_row = i
        empty_col = j
        found = true
        break
      end
    end
    break if found
  end

  return working_puzzle unless found

  occurrences.each_key do |k|
    # validate row
    next if working_puzzle[empty_row].include?(k)

    # validate column
    column = working_puzzle.map.with_index { |_, index| working_puzzle[index][empty_col] }
    next if column.include?(k)

    # validate block
    block = []
    start_row = empty_row / 3 * 3
    start_col = empty_col / 3 * 3
    (start_row...start_row + 3).each { |i| (start_col...start_col + 3).each { |j| block.push(working_puzzle[i][j]) } }
    next if block.include?(k)

    # assign value to the empty cell and validate it
    working_puzzle[empty_row][empty_col] = k

    result = sudoku(working_puzzle)

    return result if result

    # bactrack to next available option in the valid digits
    working_puzzle[empty_row][empty_col] = 0
  end

  false
end

p sudoku puzzle
