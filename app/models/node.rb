class Node < ApplicationRecord
  acts_as_taggable_on :entities
  belongs_to :statement
  
  has_many :source_connections, class_name: 'Connection', foreign_key: :source_id, dependent: :destroy
  has_many :target_connections, class_name: 'Connection', foreign_key: :target_id, dependent: :destroy
  has_many :nodes, through: :source_connections, source: :target
end
