require_relative 'my_queue'

class GraphTheory

	def initialize(graph)
		@graph = graph
	end

	def graph
		@graph.clone
	end

	def pathes_to_sinks
		# copy of the graph with edges reversed so the sinks becomes sources and vice versa.
		gr = @graph.clone.reverse!
		# copy of the source graph with no modifications, will be the the resultant graph.
		g = @graph.clone
		# iterates through all nodes from the reversed graph
		# binding.pry
		gtr = GraphTheory.new(gr)
		gr.sources.each do |n|	
			# calculate the shortest path to all nodes from the source nodes
			# iterates through all nodes checking if they have a path to n
			gtr.shortest_path(n).nodes.each do |n2|	
				unless n2["paths"]==0
					true_n = g.find_node(n2.name)
					# if they have, iterates through all the attributes of n and increment the
					# value they have on those nodes
					n.attrs.each do |key, value|
						true_n[key]=0 if true_n[key].nil?
						# binding.pry
						true_n[key] = ((true_n[key].to_i)+n2["paths"]).to_s
					end
				end
			end
		end
		g
	end

	def shortest_path(r)
		g = @graph.clone
		v = g.find_node(r.name)
		g.nodes.map { |n|
			n["state"]=0
			n["paths"]=0
		}

		vQueue = MyQueue.new
		vQueue.push(v)
		v["state"] = 1
		while(vQueue.size > 0)
			u = vQueue.pop
			u.adjacents.each do |w|
				if w["state"] == 0
					vQueue.push(w)
				end
					w["paths"]+=1
					w["state"]=1
			end
			u["state"]=2
		end

		return g
	end
end