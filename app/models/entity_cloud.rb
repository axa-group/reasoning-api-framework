class EntityCloud < Node
  acts_as_taggable_on :entities

  validates :name, presence: true, uniqueness: { scope: :statement_id }
  validates :entity_list, presence: true
end
