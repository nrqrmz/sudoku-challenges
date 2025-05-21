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
  # find empty cell
  occurrences = {}
  (1..9).to_a.each { |n| occurrences[n] = 0 }

  puzzle.each do |row|
    row.each do |n|
      occurrences[n] += 1 if occurrences.key?(n)
    end
  end

  occurrences
end

p sudoku puzzle
