class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true
  validates_inclusion_of :name, :in => %w(super_admin admin supervisor customer)

  scopify

  scope :accessible_roles, lambda { where("name <> 'super_admin'")}
end
