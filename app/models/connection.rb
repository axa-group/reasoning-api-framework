class Connection < ApplicationRecord
  belongs_to :source, class_name: 'Node', foreign_key: :source_id, primary_key: :id
  belongs_to :target, class_name: 'Node', foreign_key: :target_id, primary_key: :id

  def self.connected?(nodes)
    return false if nodes.blank?

    node_ids = nodes.map(&:id)

    # group present connections by color and rank by count
    connections_hash = Connection.where([
        "connections.source_id IN (?) AND target_id IN (?)", node_ids, node_ids
      ]).order('count_color DESC').group(:color).count('color')
    
    # group all connections by color and rank by count
    all_connections_hash = Connection::all_connections(nodes.first.statement) 

    # does a full connection exist?
    if full_connection = (all_connections_hash.to_a & connections_hash.to_a).first
      full_connection[0] # return the color
    else
      false
    end
  end

  def self.all_connections(statement)
    # returns color/count hash for all connections of the statement
    statement.connections.inject(Hash.new(0)) { |h, e| h[e.color] += 1 ; h }
  end

  def response
    source.type == "Response" ? source : (target.type == "Response" ? target : nil)
  end
end
