class Collaborators < ActiveRecord::Base
  belongs_to :mission
  belongs_to :user
    attr_accessible :type, :confirmed?
    validates :type, :include => %w( creator admin colleague viewer ) #add additional permission levels here
end
