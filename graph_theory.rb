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
		gtr = GraphTheory.new(gr)
		# iterates through all sources from the reversed graph and calculate the the number of paths
		# from they to every other node
		gr.sources.each do |n|
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
		count_paths_to_node(g,v)
		# finish = Time.now # debug
		# puts "DEBUG | #{r.name} | #{finish-start}" # debug
		return g
	end

	def count_paths_to_node(g,r)
		r["paths"]+=1
		r.adjacents.each do |v|
			count_paths_to_node(g,v)
		end
	end
	
	# def dfs
	# 	g = @graph.clone
	# 	g.nodes.map { |n|
	# 		n["state"]=0
	# 	}
	# 	g.nodes.each { |n|
	# 		if n["state"]==0
	# 			dfs_util(n)
	# 		end
	# 	}
	# end
	
	
	def strongly_connected_components
		# copy of the source graph with no modifications, will be the resultant graph.
		g_result = @graph.clone
		g = @graph.clone
		g.nodes.map { |n|
			n["state"]=0
		}
		# copy of the graph with edges reversed.
		gr = g.clone.reverse!
		cluster_count=1
		g_result.nodes.each do |n|
			if n["cluster"].nil?
				r = g.find_node(n.name)
				rr = gr.find_node(n.name)
				vr = scc_util(r)
				vrr = scc_util(rr)
				intersection = vr.map{ |x| x.name } & vrr.map{ |x| x.name }
				unless intersection.empty?
					intersection.each do |name|
						g_result.find_node(name)["cluster"] = cluster_count
					end
					cluster_count+=1
				end
				(vr+vrr).map { |x|
					x["state"]=0
				}
			end
		end
		# return the resultant graph
		return g_result
	end
	
	def scc_util(r)
		r["state"]=1
		v_tree=[]
		r.adjacents.each do |v|
			if v["state"]==0
				v_tree+=scc_util(v)
			end
		end
		v_tree << r
		
	end
end