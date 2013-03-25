class CollaboratorMailer < ActionMailer::Base
  default from: "WildSuccess@nathanotto.com"

   def new_user_invite(email_address, inviting_user, mission)
       @user = inviting_user
       @mission = mission
       
       mail to: email_address, subject: inviting_user.name + " invites you to plan a mission!"
  end
    
  def existing_user_invite(user, inviting_user, mission)
      @user = user
      @inviting_user = inviting_user
      @mission = mission
        
      mail to: user.email, subject: inviting_user.name + " invites you to plan a mission!"
  end

end
