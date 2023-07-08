class Knight
  attr_accessor :position, :parent

  def initialize(position, parent = nil)
    @position = position
    @parent = parent
  end
end

def valid_moves(position)
  moves = [
    [1, 2], [1, -2], [-1, 2], [-1, -2],
    [2, 1], [2, -1], [-2, 1], [-2, -1]
  ]
  
  valid_moves = moves.map { |move| [position[0] + move[0], position[1] + move[1]] }
  valid_moves.select { |move| move[0].between?(0, 7) && move[1].between?(0, 7) }
end

def knight_moves(start, target)
  queue = []
  visited = []

  knight = Knight.new(start)
  queue << knight

  until queue.empty?
    current_knight = queue.shift
    current_position = current_knight.position

    return trace_path(current_knight) if current_position == target

    next_moves = valid_moves(current_position)
    next_moves.each do |move|
      unless visited.include?(move)
        visited << move
        next_knight = Knight.new(move, current_knight)
        queue << next_knight
      end
    end
  end
end

def trace_path(knight)
  path = []
  current_knight = knight

  until current_knight.nil?
    path.unshift(current_knight.position)
    current_knight = current_knight.parent
  end

  puts "You made it in #{path.length - 1} moves! Here's your path:"
  path.each { |position| p position }
end

# Testing testing
knight_moves([0, 0], [1, 2])
knight_moves([0, 0], [3, 3])
knight_moves([3, 3], [0, 0])
knight_moves([3, 3], [4, 3])