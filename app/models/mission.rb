class Mission < ActiveRecord::Base
  attr_accessible :blurb, :name
    
    validates :name,  :presence => true
    validates :blurb, :presence => true,
    :length => { :minimum => 20 }
    
    has_many :drivers, :dependent => :destroy
    has_many :wild_successes, :dependent => :destroy
    has_many :constraints, :dependent => :destroy
    has_many :facts, :dependent => :destroy
    #has_many :assumptions, :dependent => :destroy
    #has_many :essential_tasks, :dependent => :destroy
    #has_many :course_of_actions, :dependent => :destroy
end
