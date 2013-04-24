class CollaboratorsController < ApplicationController
    before_filter :authenticate_user!
    
    def new
        @user = User.find(current_user.id)
        @mission = Mission.find(params[:mission_id])
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
        else
            flash[:notice] = "You must be creator, admin or have special permission to add collaborators to this mission."
            redirect_to mission_url(@mission)
        end 
    end
    
    def create
        @mission = Mission.find(params[:mission_id])
        @user = User.find(current_user.id)
        # first, email the existing users
        names_string = " "
        name_count = 0
        if params[:mission].present? then
            params[:mission][:user_ids].each do |id|
                user = User.find(id)
                names_string = names_string + user.name + ", "
                name_count += 1
                # make new collaborator here: mission, user_id, inviter_user_id
                if Collaborator.where(:user_id => user.id, :inviter_user_id => @user.id, :mission_id => @mission.id) then
                    c_new = Collaborator.where(:user_id => user.id, :inviter_user_id => @user.id, :mission_id => @mission.id).first
                else
                  c_new = Collaborator.new
                  c_new.user_id = user.id
                  c_new.inviter_user_id = @user.id
                  c_new.permission = 'colleague'
                  c_new.mission_id = @mission.id
                  c_new.confirmed = 'f'
                  c_new.can_invite = 'f' # refinement: let this be a parameter set by admins and owners
                  c_new.save
                end
                if Invitation.where(:sender_id => current_user.id, :recipient_email => user.email, :mission_id => @mission.id) then
                    i_new = Invitation.where(:sender_id => current_user.id, :recipient_email => user.email, :mission_id => @mission.id).first
                else 
                  # create the invitation also, to use the token
                  i_new = Invitation.new
                  i_new.sender = current_user
                  i_new.recipient_email = user.email
                  i_new.mission_id = @mission.id
                  i_new.save
                end 
                # send email here
                CollaboratorMailer.existing_user_invite(i_new, user).deliver
            end
        end
        # redirect_to @mission, notice: "Emailed invitations to #{names_string}."
        if name_count < 1 then names_string = "No invitations sent. ,"
            else
            names_string = "Emailed invitations to " + names_string + "."
        end 
        names_string = names_string[0..-4] + '.'
        redirect_to new_mission_invitation_path(@mission), notice: names_string
    end
    
    def confirm
        @collaborator = Collaborator.find(params[:id])
        @collaborator.update_attribute(:confirmed, 'true')
        flash[:notice] = "You are now collaborating with " + User.find(@collaborator.inviter_user_id).name + " on " + Mission.find(@collaborator.mission_id).name + "!"
                   
        CollaboratorMailer.invite_accepted(@collaborator).deliver

        redirect_to root_path
    end
    
    def destroy
        @collaborator = Collaborator.find(params[:id])
        if @collaborator.user_id == current_user.id then
            flash[:notice] = "You have declined collaboration with" + User.find(@collaborator.inviter_user_id).name + " on " + Mission.find(@collaborator.mission_id).name + "."
            @collaborator.destroy
        else
            flash[:notice] = "You are not the user invited to collaborate -- so you can't decline."
        end
        redirect_to root_path
    end 
end



