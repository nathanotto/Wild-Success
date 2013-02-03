class Clump < ActiveRecord::Base
  belongs_to :user
  belongs_to :mission
    attr_accessible :kind, :name, :user_id, :mission_id
    # validates :kind, :include => %w( success driver constraint fact assumption action )
    
    has_many :successes
    has_many :drivers
    has_many :constraints
    has_many :facts
    has_many :assumptions
    # has_many :actions
    
end
