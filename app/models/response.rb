class Response < Node
  scope :unconnected, -> { left_outer_joins(:target_connections).where(connections: {id: nil}).left_outer_joins(:source_connections).where(connections: {id: nil}).uniq }
end
