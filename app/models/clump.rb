class Clump < ActiveRecord::Base
  belongs_to :user
  belongs_to :mission
    attr_accessible :kind, :name, :user_id, :mission_id
    
    has_many :stickies
    # has_many :actions
    
end
