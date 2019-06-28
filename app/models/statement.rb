class Statement < ApplicationRecord
  belongs_to :contract
  has_many :nodes, dependent: :destroy
  has_many :entity_clouds, dependent: :destroy
  has_many :number_ranges, dependent: :destroy
  has_many :date_ranges, dependent: :destroy
  has_many :responses, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :contract_id }
  accepts_nested_attributes_for :entity_clouds, allow_destroy: true
  accepts_nested_attributes_for :number_ranges, allow_destroy: true
  accepts_nested_attributes_for :date_ranges, allow_destroy: true
  accepts_nested_attributes_for :responses, allow_destroy: true
  validates_associated :nodes
  after_save :update_connections

  attr_accessor :diagram

  validate :diagram_integrity, unless: Proc.new { |s| s.diagram_xml.blank? }

  def diagram
    @diagram || (@diagram = Diagram.new(diagram_xml))
  end

  def diagram=(val)
    @diagram = val
  end

  def response(color)
    source_connections = responses.map{|r| r.source_connections}.flatten.select{|rc| rc.color == color}
    target_connections = responses.map{|r| r.target_connections}.flatten.select{|rc| rc.color == color}
    [source_connections + target_connections].flatten.first.try(:response)
  end

  def connections
    nodes.map{|n| n.source_connections}.flatten.uniq
  end

  def parameters
    nodes.map{|n| n.parameter}.flatten.uniq.reject(&:blank?)
  end

  private
  def diagram_integrity
    if (Diagram.new(diagram_xml)).invalid?
      errors.add(:diagram_xml, "is invalid")
    end
  end

  def update_connections
    
    # delete old connections
    nodes.each do |n|
      n.source_connections.destroy_all
      n.target_connections.destroy_all
    end

    # create new connections
    diagram.connections.each do |source_timestamp, target_timestamp, color|
      Connection.create(source: nodes.where(timestamp: source_timestamp).first, target: nodes.where(timestamp: target_timestamp).first, color: color)
    end
  end

end
