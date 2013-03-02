class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable #, :confirmable #turn this back on when you set up emailing for the app

  # Setup accessible (or protected) attributes for your model
    attr_accessible :email, :password, :password_confirmation, :remember_me, :name
    validates :name,  :presence => true
    # attr_accessible :title, :body
    
    # has_many :missions
    has_many :collaborators
    has_many :successess
    has_many :drivers
    has_many :constraints
    has_many :facts
    has_many :assumptions
    has_many :stickies
    # has_many :actions
    # has_many :missions, :through => :collaborators
end
