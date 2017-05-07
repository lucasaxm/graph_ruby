$:.unshift File.expand_path("../gem/Ruby-Graphviz-master/lib", __FILE__)

# require_relative "ruby-graphviz-1.2.3/lib/graphviz"
require 'graphviz'
require "pry"

require_relative 'graph'
require_relative 'node'
require_relative 'edge'
require_relative 'graph_theory'

# input = ARGF.read

# puts 'input:'
# puts input
# binding.pry
case 3
    when 1
        graph = Graph.new_from_dot(ARGF.read)
    when 2
        graph = Graph.new('prova')
        graph.directed = true
        
        graph.add_node(node1 = Node.new('Node #1'))
        graph.add_node(node2 = Node.new('Node #2'))
        graph.add_node(node3 = Node.new('Node #3'))
        graph.add_node(node4 = Node.new('Node #4'))
        graph.add_node(node5 = Node.new('Node #5'))
        
        graph.add_edge(Edge.new(node1,node3))
        graph.add_edge(Edge.new(node3,node5))
        graph.add_edge(Edge.new(node5,node2))
        graph.add_edge(Edge.new(node5,node4))
        graph.add_edge(Edge.new(node2,node4))
        
        if (File.write("test.dot", graph.to_s))
          GraphViz.parse( "test.dot", :path => "." ).output(:png => "test.png")
        else
          puts "error writing graph"
        end
    when 3
        graph = Graph.gviz2graph(GraphViz.parse( "test.dot", :path => "." ))
end
gt = GraphTheory.new(graph)
puts "graph.name: "+graph.name.to_s
puts "graph.directed: "+graph.directed.to_s
puts "graph.weighted: "+graph.weighted.to_s
puts "graph.nodes.size: "+graph.nodes.size.to_s
puts "graph.edges.size: "+graph.edges.size.to_s
puts
puts "graph.edges: "
graph.edges.map{ |e| puts e.to_s }
puts
puts "graph.nodes.first.name: "+graph.nodes.first.name.to_s
puts "graph.nodes.first.degree: "+graph.nodes.first.degree.to_s
puts "graph.nodes.first.indegree: "+graph.nodes.first.indegree.to_s
puts "graph.nodes.first.outdegree: "+graph.nodes.first.outdegree.to_s
puts "graph.nodes.first.attrs: "+graph.nodes.first.attrs.to_s
puts "graph.to_s: "+graph.to_s
binding.pry
puts "gt.pathes_to_sinks: "+ gt.pathes_to_sinks.to_s