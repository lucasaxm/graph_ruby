class Graph
  attr_accessor :name,
                :directed

  attr_reader   :nodes,
                :edges

  def initialize(name, nodes=[], edges=[], directed=false)
    @name = name
    @nodes = nodes
    @edges = edges
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
    ret = "#{'di' if self.directed}graph #{self.name}{\n\n"
    self.nodes.each { |node|
      ret+="\t#{node};\n"
    }
    ret+="\n"
    self.edges.each { |edge|
      ret+="\t#{edge};\n"
    }
    ret+='}'
    return ret
  end

  def weighted
    if self.edges.empty?
      return false
    elsif self.edges.first["peso"].nil?
      return false
    else
      return true
    end
  end
  
  def self.new_from_dot(dot_string)
    gviz = GraphViz.parse_string(dot_string)
    
    return gviz2graph(gviz)
  end

  def self.gviz2graph(gviz)
    g = Graph.new(gviz.name)
    
    gviz.each_node do |name, node|
      new_node = Node.new(name)
      node.each_attribute do |attr|
        if attr!="label" && !node[attr].empty?
          new_node[attr]=node[attr];
        end
      end
      g.add_node(new_node)
    end

    gviz.each_edge do |edge|
      tail = g.find_node(edge.tail_node(true,false))
      head = g.find_node(edge.head_node(true,false))
      new_edge = Edge.new(tail, head)
      edge.each_attribute do |attr|
        if !edge[attr].empty?
          new_edge[attr]=edge[attr];
        end
      end
      g.add_edge(new_edge)
    end
    
    g.directed = (gviz.type == "digraph")
    
    return g
  end

end