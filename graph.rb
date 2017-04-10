class Graph
  attr_accessor :nodes,
                :edges,
                :name,
                :weighted,
                :directed

  def initialize(name, nodes=[], edges=[], weighted=false, directed=false)
    @name = name
    @nodes = nodes
    @edges = edges
    @weighted = weighted
    @directed = directed
  end
  

  def add_node(node)
    nodes << node
    node.graph = self
  end

  def add_edge(edge)
    edges << edge
    edge.graph = self
  end

  def find_node(name)
    return nodes.select{ |n| n.name == name }.first
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
  
  def self.new_from_dot(dot_string)
    gdot = GraphViz.parse_string(dot_string)
    
    g = Graph.new(gdot.name)
    
    gdot.each_node do |name, node|
      g.add_node(Node.new(name))
    end

    gdot.each_edge do |edge|
      tail = g.find_node(edge.tail_node(true,false))
      head = g.find_node(edge.head_node(true,false))
      g.add_edge(Edge.new(tail, head, edge["weight"]))
    end
    
    if (g.edges.empty?)
      g.weighted = false
    else
      g.weighted = !g.edges.first.weight.nil?
    end
    
    g.directed = (gdot.type == "digraph")
    
    return g
  end
end