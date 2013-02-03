class Success < ActiveRecord::Base
  belongs_to :mission
    belongs_to :user
    belongs_to :clump
  attr_accessible :name, :user_id
    validates :name, :presence => true
    
    #has_many :coactions #need to connect to course_of_action_id

end
