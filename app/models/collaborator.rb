class Collaborator < ActiveRecord::Base
    belongs_to :mission
    belongs_to :user
    attr_accessible :permission, :confirmed, :user_id, :mission_id
    # validates :permission, :include => %w( creator admin colleague viewer ) #add additional permission levels here
end
