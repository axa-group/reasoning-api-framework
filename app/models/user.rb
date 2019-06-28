class User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :contracts

  delegate :can?, :cannot?, :to => :ability

  ROLES = %i[admin manager]

  def to_s
    email
  end

  def contracts
    if role == "admin"
      Contract.all
    else
      super
    end
  end
end
