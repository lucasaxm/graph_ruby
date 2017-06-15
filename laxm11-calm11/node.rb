class Node
  attr_accessor :name,
                :graph
  attr_reader   :attrs

  def initialize(name)
    @name = name
    @attrs = {}
  end

  def []( key )
    @attrs[key.to_s]
  end

  def []=( key, value )
    if value.nil? || key.nil?
      warn "Key and Value can't be null"
      return
    end

    if key.class != String
      warn "Key must be a String."
      return
    end

    if (defined?(value.empty?) && value.empty?) || key.empty?
      warn "Value and Key can't be empty (if string)."
      return
    end

    @attrs[key]=value
  end

  def adjacents
    if graph.directed
      graph.edges.select{|e| e.from == self}.map(&:to)
    else
      graph.edges.select{|e| e.from == self || e.to == self}.map(&:to)
    end
  end

  def to_s
    ret="\"#{self.name}\""
    attributes=self.attrs.select{|x| x != "cluster"}
    unless attributes.empty?
      ret+=" ["
      attributes.each_with_index do |(key,value),index|
        ret+="#{key}=#{value}"
        if index!=attributes.size-1
          ret+=", "
        else
          ret+="]"
        end
      end
    end
    
    ret
  end

  def degree
    self.adjacents.size
  end
  
  def indegree
    graph.edges.select{|e| e.to == self}.map(&:to).size
  end
  
  def outdegree
    self.degree
  end

  
end