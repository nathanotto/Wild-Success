class InvitationsController < ApplicationController
    
  def new
      @mission = Mission.find(params[:mission_id])
      @invitation = Invitation.new
  end

  def create
      # look for the email in the user database, and issue a collaboration invite if the email address is found
    @mission = Mission.find(params[:mission_id])
      if User.find_by_email(params[:invitation][:recipient_email]) then
          user = User.find_by_email(params[:invitation][:recipient_email])
        # check if the collaboration is a duplicate
          if  !(Collaborator.where(:user_id => user.id, :inviter_user_id => current_user.id, :mission_id => @mission.id)) then
            c_new = Collaborator.new
            c_new.user_id = user.id
            c_new.inviter_user_id = current_user.id
            c_new.permission = 'colleague'
            c_new.mission_id = @mission.id
            c_new.confirmed = 'f'
            c_new.can_invite = 'f' # refinement: let this be a parameter set by admins and owners
            c_new.save
            # send email here
            CollaboratorMailer.existing_user_invite(user, current_user, @mission).deliver
        end 
        redirect_to mission_stickies_path(@mission, :kind => 'success'), :notice => user.email + " is already signed up. Invitation sent."
    else
        @invitation = Invitation.new(params[:invitation])
        @invitation.mission_id = @mission.id
        @invitation.sender = current_user
        if @invitation.save
            # send email here
            CollaboratorMailer.new_user_invite(@invitation).deliver
            redirect_to mission_stickies_path(@mission, :kind => 'success'), :notice => "Thank you, invitation sent."
        else
            render :action => 'new'
        end
    end
  end
    
    def accept #controller for when a new user clicks an email link to accept an invitation
        @invitation = Invitation.find_by_token(params[:token])
        @mission = Mission.find(@invitation.mission_id)
        # check again to see if the user signed up in the interim of responding to the invitation email
        if User.find_by_email(@invitation.recipient_email) then
            @user = User.find_by_email(@invitation.recipient_email)
            # make sure the collaboration is not a duplicate
            if  !(Collaborator.where(:user_id => @user.id, :inviter_user_id => current_user.id, :mission_id => @mission.id)) then
                c_new = Collaborator.new
                c_new.user_id = @user.id
                c_new.inviter_user_id = @invitation.sender_id
                c_new.permission = 'colleague' #refinement to invite admins
                c_new.mission_id = @mission.id
                c_new.confirmed = 't'
                c_new.can_invite = 'f' # refinement: let this be a parameter set by admins and owners
                c_new.save
                # send email here
                CollaboratorMailer.invite_accepted(@invitation).deliver
            end
            redirect_to mission_path(@mission), :notice => "You are now collaborating with " + User.find(@invitation.sender.id).name + "."
        else # need to create a new user to record collaboration
            
            redirect_to new_user_registration_path(:token => @invitation.token)
            
         end 
    end
end

# When a new invitation is issued, then the link goes to a process that:
#   1. Generates a new user from a new user form
#   2. Generates a collaboration for the mission in the collaborations table: inviting user, new user, mission.
#   3. Generates a notification for the inviting user in the notifications table.
#   4. Takes the new user into a mission planning sequence
