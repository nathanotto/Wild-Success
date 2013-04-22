class Mission < ActiveRecord::Base
    attr_accessible :blurb, :name, :is_public
    
    validates :name,  :presence => true
    # validates :blurb, :presence => true,
    # :length => { :minimum => 20 }
    
    has_many :collaborators
    has_many :users, :through => :collaborators

    # has_many :collaborators
    has_many :clumps, :dependent => :destroy
    has_many :stickies, :dependent => :destroy
    #has_many :essential_tasks, :dependent => :destroy
    has_many :coactions, :dependent => :destroy
    # belongs_to :users
    has_many :invitations, :dependent => :destroy
end
