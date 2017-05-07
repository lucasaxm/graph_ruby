require_relative 'graph'
require_relative 'graph_theory'

g = Graph.new_from_dot(ARGF.read)
gt = GraphTheory.new(g)
puts gt.pathes_to_sinks.to_s