class Sticky < ActiveRecord::Base
  belongs_to :mission
  belongs_to :user
  belongs_to :clump
    attr_accessible :name, :user_id, :mission_id, :kind
end
