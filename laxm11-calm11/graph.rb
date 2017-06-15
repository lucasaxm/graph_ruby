$:.unshift File.expand_path("../gem/Ruby-Graphviz-master/lib", __FILE__)
require 'graphviz'
require_relative 'node'
require_relative 'edge'

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
    node
  end

  def add_edge(edge)
    edges << edge
    edge.graph = self
    edge
  end

  def find_node(name)
    return nodes.select{ |n| n.name == name }.first
  end

  def reverse!
    self.edges.each do |e|
      e.from, e.to = e.to, e.from
    end
    self
  end

  def to_s
    ret = "#{'di' if self.directed}graph #{self.name}{\n\n"
    if self.nodes.first["cluster"].nil?
      self.nodes.each { |node|
        ret+="\t#{node};\n"
      }
    else
      cluster_count=1
      while !(subgraph=self.nodes.select{|x| x["cluster"]==cluster_count}).empty?
        ret+="\tsubgraph cluster#{cluster_count} {\n"
        subgraph.each { |node|
          ret+="\t\t#{node};\n"
        }
        ret+="\t}\n"
        cluster_count+=1
      end
    end
    ret+="\n"
    self.edges.each { |edge|
      ret+="\t#{edge};\n"
    }
    ret+='}'
    return ret
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
        unless attr=="label" || (defined?(node[attr].empty?) && node[attr].empty?)
          new_node[attr]=node[attr];
        end
      end
      g.add_node(new_node)
      # puts "DEBUG | #{new_node.to_s}" # debug
    end

    gviz.each_edge do |edge|
      tail_node_name = edge.tail_node(true,false)
      tail = g.find_node(tail_node_name)
      if tail.nil?
        tail = g.add_node(Node.new(tail_node_name))
      end
      
      head_node_name = edge.head_node(true,false)
      head = g.find_node(head_node_name)
      if head.nil?
        head = g.add_node(Node.new(head_node_name))
      end
      new_edge = Edge.new(tail, head)
      edge.each_attribute do |attr|
        if !edge[attr].empty?
          new_edge[attr]=edge[attr];
        end
      end
      g.add_edge(new_edge)
      # puts "DEBUG | #{new_edge.to_s}" # debug
    end
    
    g.directed = (gviz.type == "digraph")
    
    return g
  end

  def clone
    Marshal.load(Marshal.dump(self))
  end

  def sinks
    self.nodes.select{ |n| n.outdegree==0 }
  end

  def sources
    self.nodes.select{ |n| n.indegree==0 }
  end

end