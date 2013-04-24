class CollaboratorMailer < ActionMailer::Base
  default from: "WildSuccess@nathanotto.com"

   def new_user_invite(invitation)
       @user = User.find(invitation.sender.id)
       @mission = Mission.find(invitation.mission_id)
       @invitation = invitation
       
       mail to: @invitation.recipient_email, subject: @user.name + " invites you to plan a mission!"
  end
    
  def existing_user_invite(inviter, recipient, mission)
      @user = recipient 
      @inviting_user = inviter 
      @mission = mission 
        
      mail to: recipient.email, subject: "#{@inviting_user.name} invites you to plan a mission!"
  end
    
  def invite_accepted(collaborator)
      @sender = User.find(collaborator.inviter_user_id)
      @invitee = User.find(collaborator.user_id)
      @mission = Mission.find(collaborator.mission_id)
      
      mail to: @sender.email, subject: @invitee.name + " accepted your invitation to collaborate!"
      
  end 


end
