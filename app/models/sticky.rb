class Sticky < ActiveRecord::Base
  belongs_to :mission
  belongs_to :user
  belongs_to :clump
  has_and_belongs_to_many :coactions
    attr_accessible :name, :user_id, :mission_id, :kind, :coaction_id, :position
  validates :name,  :presence => true
 
end
