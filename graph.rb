class Graph
  attr_accessor :nodes,
                :edges,
                :name,
                :weighted,
                :directed

  def initialize(name)
    @nodes = []
    @edges = []
    @name = name
    @weighted = false
  end

  def add_node(node)
    nodes << node
    node.graph = self
  end

  def add_edge(edge)
    edges << edge
    edge.graph = self
  end

  def reverse!
    edges.each do |e|
      e.from, e.to = e.to, e.from
    end
  end

  def to_s
    ret = "#{'di' if self.directed}graph #{self.name}{\n"
    self.edges.each { |edge|
      ret+="\t#{edge}\n"
    }
    ret+='}'
    return ret
  end
end