class InvitationsController < ApplicationController
    
  def new
      @mission = Mission.find(params[:mission_id])
      @user = current_user
      @invitation = Invitation.new
      @collaborator = Collaborator.where(:user_id => @user.id, :mission_id => @mission.id).first
      # Only an ownwer, adminstrator, or specific permisson can invite collaborators
      if ((@collaborator.permission == 'admin') || (@collaborator.permission == 'creator')) || (@collaborator.can_invite) then # NEED to set up permission-to-invite privileges granted by admin.
          u_ids = @mission.user_ids
          m_ids = @user.mission_ids
          m_ids.each do |m_id|
              mission = Mission.find(m_id)
              u_ids = u_ids + mission.user_ids
          end
          # delete the current user from collaborators
          u_ids.delete_if{|u| u == @user.id }
          # delete the users already collaborating
          @mission.users.each do |user|
              u_ids.delete_if{|u| u == user.id }
          end
          if !u_ids.empty? then @users = User.find(u_ids) end
          if params.has_key?(:search) then
              if @users then @users = @users + User.search(params[:search])[0..19]
                else @users = User.search(params[:search])[0..19]
              end 
              @users.uniq!
              @users = @users - @mission.users
          end
        else
          flash[:notice] = "You must be creator, admin or have special permission to add collaborators to this mission."
          redirect_to mission_url(@mission)
      end

  end

  def create
      # look for the email in the user database, and issue a collaboration invite if the email address is found
    @mission = Mission.find(params[:mission_id])
      if User.find_by_email(params[:invitation][:recipient_email]) then
          user = User.find_by_email(params[:invitation][:recipient_email])
          invitation = Invitation.new(params[:invitation])
          invitation.mission_id = @mission.id
          invitation.sender = current_user
          # note, there is no need for @invitation.save, as we don't ever use it again
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
            CollaboratorMailer.existing_user_invite(invitation, user).deliver
        end 
        redirect_to new_mission_invitation_path(@mission), :notice => user.email + " is already signed up. Invitation sent. Invite another?"
    else
        @invitation = Invitation.new(params[:invitation])
        @invitation.mission_id = @mission.id
        @invitation.sender = current_user
        if @invitation.save
            # send email here
            CollaboratorMailer.new_user_invite(@invitation).deliver
            redirect_to new_mission_invitation_path(@mission), :notice => "Invitation sent to " + @invitation.recipient_email + ". Invite another?"
        else
            redirect_to new_mission_invitation_path(@mission), :notice => params[:invitation][:recipient_email] + " is blank or didn't work. Try another one?"
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
                CollaboratorMailer.invite_accepted(c_new).deliver
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
