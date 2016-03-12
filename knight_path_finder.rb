require 'byebug'
require_relative 'poly_tree_node'

class KnightPathFinder
  DELTAS =[
    [1, 2],
    [1, -2],
    [-1, 2],
    [-1, -2],
    [2, 1],
    [2, -1],
    [-2, 1],
    [-2, -1]
  ]

  def self.valid_moves(pos)
    row, col = pos
    possible_moves = DELTAS.select do |d_row, d_col|
      new_row = row + d_row
      new_col = col + d_col
      new_row.between?(0, 7) && new_col.between?(0, 7)
    end
    possible_moves.map {|d_row, d_col| [d_row + row, d_col + col]  }
  end

  attr_reader :visited_positions

  def initialize(pos = [0, 0])
    @initial_pos = pos
    @visited_positions = [@initial_pos]
  end

  def new_move_positions(pos)
    new_moves = KnightPathFinder.valid_moves(pos).reject do |move|
      @visited_positions.include?(move)
    end
    @visited_positions += new_moves
    new_moves
  end

  def build_move_tree
    root = PolyTreeNode.new(@initial_pos)
    @visited_positions = [@initial_pos]
    queue = [root]

    until queue.empty?
      node = queue.shift
      new_move_positions(node.value).each do |pos|
        new_child = PolyTreeNode.new(pos)
        node.add_child(new_child)
        queue << new_child
      end
    end
    root
  end

  def find_path(end_pos)
    root = build_move_tree
    end_node = root.dfs(end_pos)
    trace_path_back(end_node)
  end

  def trace_path_back(end_node)
    path = [end_node.value]
    parent = end_node.parent

    until parent.nil?
      path << parent.value
      parent = parent.parent
    end

    path.reverse

  end

end

game = KnightPathFinder.new

p game.find_path([7, 6])
p game.find_path([6, 2])





  # def build_move_tree
  #   root = PolyTreeNode.new(@initial_pos)
  # end


# def self.valid_moves(pos)
#   possible_moves = []
#   row, col = pos
#   DELTAS.each do |delta|
#     d_row, d_col = delta
#     possible_move = [row + d_row, col + d_col]
#     possible_moves << possible_move if valid_pos?(possible_move)
#   end
#   possible_moves
# end
#
# def self.valid_pos?(pos)
#   row, col = pos
#   row.between?(0,7) && col.between?(0,7)
# end
