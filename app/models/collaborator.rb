class Collaborator < ActiveRecord::Base
    belongs_to :mission
    belongs_to :user
    attr_accessible :permission, :confirmed, :user_id, :mission_id
    #add additional permission levels here:
    validates :permission, :inclusion => { :in => ["creator", "admin", "colleague", "viewer"] } 
end
