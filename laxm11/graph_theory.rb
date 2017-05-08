class GraphTheory

	def initialize(graph)
		@graph = graph
	end

	def graph
		@graph.clone
	end

	def paths_to_sinks
		# copy of the graph with edges reversed so the sinks becomes sources and vice versa.
		gr = @graph.clone.reverse!
		# copy of the source graph with no modifications, will be the resultant graph.
		g = @graph.clone
		# iterates through all nodes from the reversed graph
		gtr = GraphTheory.new(gr)
		gr.sources.each do |n|
			# calculate the the number of paths from the source nodes to every other node
			# iterates through all nodes checking if they have a path to n
			g_with_paths = gtr.all_paths(n)
			g_with_paths.nodes.each do |n2|	
				unless (n2["paths"]==0) || (n.name==n2.name)
					true_n = g.find_node(n2.name)
					# if they have, iterates through all the attributes of n and increment the
					# value they have on those nodes
					n.attrs.each do |key, value|
						true_n[key]=0 if true_n[key].nil?
						true_n[key] = ((true_n[key].to_i)+n2["paths"]).to_s
					end
				end
			end
		end
		# return the resultant graph
		return g
	end

	def all_paths(r)
		# start = Time.now # debug
		g = @graph.clone
		v = g.find_node(r.name)
		g.nodes.map { |n|
			n["state"]=0
			n["paths"]=0
		}
		depth_first_search_node(g,v)
		# finish = Time.now # debug
		# puts "DEBUG | #{r.name} | #{finish-start}" # debug
		return g
	end

	def depth_first_search_node(g,r)
		r["paths"]+=1
		r.adjacents.each do |v|
			depth_first_search_node(g,v)
		end
	end
end