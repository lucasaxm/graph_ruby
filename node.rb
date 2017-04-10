class Node
  attr_accessor :name, :graph

  def initialize(name)
    @name = name
  end

  def adjacents
    if graph.directed
      graph.edges.select{|e| e.from == self}.map(&:to)
    else
      graph.edges.select{|e| e.from == self || e.to == self}.map(&:to)
    end
  end

  def to_s
    @name
  end

  def degree
    self.adjacents.size
  end

  def outdegree

  end

  def indegree

  end

end