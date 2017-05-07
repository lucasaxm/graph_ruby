require_relative 'graph'
require_relative 'graph_theory'

case 1
    when 1
        graph = Graph.new_from_dot(ARGF.read)
    when 2
        # start = Time.now # debug
        graph = Graph.gviz2graph(GraphViz.parse( "dots/teste4.dot", :path => "." ))
        # finish = Time.now # debug
        # puts "DEBUG | parse | #{finish-start}" # debug
end
gt = GraphTheory.new(graph)
puts gt.pathes_to_sinks.to_s