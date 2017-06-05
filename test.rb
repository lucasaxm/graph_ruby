#!/usr/bin/env ruby

require_relative 'graph'
require_relative 'graph_theory'

case 2
    when 1
        graph = Graph.new_from_dot(ARGF.read)
    when 2
        # start = Time.now # debug
        graph = Graph.gviz2graph(GraphViz.parse( "dots/emacs24-dep-FIM.dot", :path => "." ))
        # finish = Time.now # debug
        # puts "DEBUG | parse | #{finish-start}" # debug
end
gt = GraphTheory.new(graph)
puts gt.strongly_connected_components