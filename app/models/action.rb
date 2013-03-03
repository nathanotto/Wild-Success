class Action < ActiveRecord::Base
  belongs_to :mission
  belongs_to :user
    has_many :stickies
    attr_accessible :committed_user, :deadline, :name, :priority, :user_id
end
