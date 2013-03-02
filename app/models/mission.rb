class Mission < ActiveRecord::Base
    attr_accessible :blurb, :name, :is_public
    
    validates :name,  :presence => true
    # validates :blurb, :presence => true,
    # :length => { :minimum => 20 }
    

    has_many :collaborators
    has_many :clumps
    has_many :stickies
    #has_many :users, :through => collaborators
    #has_many :essential_tasks, :dependent => :destroy
    #has_many :actions, :dependent => :destroy
    # belongs_to :users
end
