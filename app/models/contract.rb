class Contract < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :statements, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end
