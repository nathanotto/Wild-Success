class Success < ActiveRecord::Base
  belongs_to :mission
  attr_accessible :name
    validates :name, :presence => true
    
    #has_many :coactions #need to connect to course_of_action_id

end
