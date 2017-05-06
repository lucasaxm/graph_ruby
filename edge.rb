class Edge
  attr_accessor :from,
                :to,
                :graph
  attr_reader   :attrs

  def initialize(from, to, weight=1)
    @from, @to, @weight = from, to, weight
    @attrs = {}
  end

  def <=>(other)
    self.weight <=> other.weight
  end

  def to_s
    ret = "\"#{from.name}\" -#{graph.directed ? '>' : '-'} \"#{to.name}\""

    if !self.attrs.empty?
      ret+=" ["

      self.attrs.each_with_index do |(key,value),index|
        ret+="#{key}=#{value}"
        if index!=self.attrs.size-1
          ret+=" "
        else
          ret+="]"
        end
      end

    end
    
    ret
  end

  def []( key )
    @attrs[key.to_s]
  end

  def []=( key, value )
    if value.nil? || key.nil?
      warn "Key and Value can't be null"
      return
    end

    if (value.class != String) || (key.class != String)
      warn "Key and Value must be a String."
      return
    end

    if value.empty? || key.empty?
      warn "Value and Key can't be empty."
      return
    end

    @attrs[key]=value
  end
end