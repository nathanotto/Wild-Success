class Coaction < ActiveRecord::Base
  belongs_to :mission
  belongs_to :user
    has_and_belongs_to_many :stickies
    attr_accessible :committed_user, :deadline, :name, :priority, :user_id, :mission_id
end
