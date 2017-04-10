class Edge
  attr_accessor :from, :to, :weight, :graph

  def initialize(from, to, weight=1)
    @from, @to, @weight = from, to, weight
  end

  def <=>(other)
    self.weight <=> other.weight
  end

  def to_s
    "\"#{from.to_s}\" -#{graph.directed ? '>' : '-'} \"#{to.to_s}\"#{' [weight='+weight+']' if graph.weighted};"
  end
end