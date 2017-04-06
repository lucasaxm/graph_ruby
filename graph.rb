class Graph
  attr_accessor :nodes, :edges, :name
  attr_writer :directed
  
  Directed=true
  NotDirected=false
  
  def initialize(name,directed)
    @nodes = []
    @edges = []
    @name = name
    @directed = directed
  end
  
  def is_directed?
    return @directed
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
    ret = "#{"di" if self.is_directed?}graph #{self.name}{\n"
    self.edges.each { |edge|
      ret+="\t#{edge}\n"
    }
    ret+="}"
    return ret
  end
end