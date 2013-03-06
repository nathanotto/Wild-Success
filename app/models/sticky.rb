class Sticky < ActiveRecord::Base
  belongs_to :mission
  belongs_to :user
  belongs_to :clump
  belongs_to :coaction
    attr_accessible :name, :user_id, :mission_id, :kind
end
