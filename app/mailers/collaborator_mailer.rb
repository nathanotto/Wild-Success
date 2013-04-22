class CollaboratorMailer < ActionMailer::Base
  default from: "WildSuccess@nathanotto.com"

   def new_user_invite(invitation)
       @user = User.find(invitation.sender.id)
       @mission = Mission.find(invitation.mission_id)
       @invitation = invitation
       
       mail to: @invitation.recipient_email, subject: @user.name + " invites you to plan a mission!"
  end
    
  def existing_user_invite(user, inviting_user, mission)
      @user = user
      @inviting_user = inviting_user
      @mission = mission
        
      mail to: user.email, subject: inviting_user.name + " invites you to plan a mission!"
  end
    
  def invite_accepted(invitation)
      @user = User.find(invitation.sender.id)
      @mission = Mission.find(invitation.mission_id)
      @invitation = invitation
      
      mail to: @user.email, subject: invitation.recipient_email + " accepted your invitation to collaborate!"
      
  end 


end
