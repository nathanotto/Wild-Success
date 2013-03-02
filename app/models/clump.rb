class Clump < ActiveRecord::Base
  belongs_to :user
  belongs_to :mission
    attr_accessible :kind, :name, :user_id, :mission_id
    # validates :kind, :include => %w( success driver constraint fact assumption action )
    
    has_many :stickies
    # has_many :actions
    
end
