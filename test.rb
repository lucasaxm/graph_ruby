require "graphviz"
require_relative "graph"
require_relative "node"
require_relative "edge"

# graph = Graph.new("prova",Graph::NotDirected)
graph = Graph.new("prova",Graph::NotDirected)

graph.add_node(node1 = Node.new("Node #1"))
graph.add_node(node2 = Node.new("Node #2"))
graph.add_node(node3 = Node.new("Node #3"))
graph.add_node(node4 = Node.new("Node #4"))
graph.add_node(node5 = Node.new("Node #5"))

graph.add_edge(Edge.new(node1,node3,1))
graph.add_edge(Edge.new(node3,node5,1))
graph.add_edge(Edge.new(node5,node2,1))
graph.add_edge(Edge.new(node5,node4,1))
graph.add_edge(Edge.new(node2,node4,1))

# puts graph.edges
if (File.write("test.dot", graph.to_s))
    GraphViz.parse( "test.dot", :path => "." ).output(:png => "test.png")
else
    puts "error writing graph"
end
