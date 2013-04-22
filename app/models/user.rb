class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable, :invitable #turn this back on when you set up emailing for the app

  # Setup accessible (or protected) attributes for your model
    attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :id, :token
    validates :name,  :presence => true
    # attr_accessible :title, :body
    
    # has_many :missions
    has_many :collaborators
    has_many :missions, :through => :collaborators
    has_many :stickies
    has_many :coactions
    # has_many :missions, :through => :collaborators
    
    has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => 'sender_id'
    belongs_to :invitation
    
    before_create :set_invitation_limit
   
    
    def set_invitation_limit
        self.invitation_limit = 25
    end
    
    def token=(token)
        self.invitation = Invitation.find_by_token(token)
    end

end
