#
# Direction class that defines node direction to other node (for example A => B, etc)
#
class Direction

  # Attribute readers
  attr_reader :node, :weight

  # Class initialization method
  # @param [String] node Node title (for example A, B, C, etc)
  # @param [Integer] weight Node edge weight
  def initialize(node, weight)
    @node = node
    @weight = weight
  end
end
