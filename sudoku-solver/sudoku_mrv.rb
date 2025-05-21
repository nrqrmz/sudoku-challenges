def solve(puzzle)
  # copy puzzle
  working_puzzle = puzzle.map(&:dup)

  # return the puzzle if it is solved
  return working_puzzle if solved?(working_puzzle)

  # find empty cell with less possibilities (MRV)
  row, col, possible_values = find_cell_with_mrv(working_puzzle)

  return false unless row # No solution

  possible_values.each do |value|
    working_puzzle[row][col] = value
    result = solve(working_puzzle)
    return result if result

    working_puzzle[row][col] = 0 # backtrack
  end

  false
end

# verify the puzzle is solved
def solved?(grid)
  grid.all? { |row| row.none?(0) }
end

# return valid digits for a cell
def valid_values(grid, row, col)
  return [] unless grid[row][col].zero?

  used = Set.new(grid[row])
  used.merge(grid.map { |r| r[col] })

  start_row = row / 3 * 3
  start_col = col / 3 * 3
  3.times do |i|
    3.times do |j|
      used.add(grid[start_row + i][start_col + j])
    end
  end

  (1..9).to_a - used.to_a
end

# find the cell with the minimum remaining values (MRV)
def find_cell_with_mrv(grid)
  min_options = 10
  best_cell = nil
  best_values = []

  grid.each_with_index do |row, i|
    row.each_with_index do |val, j|
      next unless val.zero?

      options = valid_values(grid, i, j)
      if options.size < min_options
        min_options = options.size
        best_cell = [i, j]
        best_values = options
        return [i, j, options] if min_options == 1 # early exit
      end
    end
  end

  best_cell ? [best_cell[0], best_cell[1], best_values] : [nil, nil, []]
end
