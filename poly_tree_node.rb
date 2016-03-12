class PolyTreeNode

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

def root_node?
  parent.nil?
end

  # def assign_parent(parent)
  #   @parent = parent
  #   parent.children
  # end
  def parent=(new_parent)
    #Alternative way: @parent.children.reject! { |child| child == self}
    parent.children.delete(self) unless self.root_node?
    @parent = new_parent
    new_parent.children << self unless new_parent.nil?
  end

  def children
    @children
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    if children.include?(child_node)
      child_node.parent = nil
    else
      raise "Error! Parent does not have this child."
    end
  end

  def value
    @value
  end

  def inspect
    @value.inspect
  end

  def dfs(target_value)
    return self if self.value == target_value
    children.each do |child|
      #Rather than making two recursive calls, we save the return value of the recursive call in a variable, and then (do stuff) with that variable.
       result = child.dfs(target_value)
       return result unless result.nil?
    end
    nil
  end

  # def dfs(target_value)
  #   return self if value == target_value
  #   return nil if children.empty?
  #   children.each do |child|
  #      child.dfs(target_value)
  #   end
  # end


  def bfs(target_value)
    queue = []

    queue.push(self)

    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target_value
      current_node.children.each do |child|
        queue.push(child)
      end
    end
    nil
  end

end
