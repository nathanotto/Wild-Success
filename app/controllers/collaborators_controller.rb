class CollaboratorsController < ApplicationController
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
                
                
            @users = User.find(u_ids)
            @users = @users.reject { |h| @users.include? h['email'] }
            # @users = User.all
           
        else
            flash[:notice] = "You must be creator, admin or have special permission to add collaborators to this mission."
            redirect_to mission_url(@mission)
        end 
    end
    
    def create
        # This function will be given a list of proposed collaborators, who then
        # need to confirm that they are collaborating.
        # collaboration invitations show up on users screens with confirmations
        # some collaborators are invited by email and don't have accounts
        # they will have accounts created when email is sent
        # the confirmation of the the email confirms both the user and the collaborator
        # ALL proposed collaborators will be sent emails
        @mission = Mission.find(params[:mission_id])
        @user = User.find(current_user.id)
        $param = params
        redirect_to new_mission_collaborator_path(@mission)
    end
    
    def confirm
        @collaborator = Collaborator.find(params[:id])
        @collaborator.update_attribute(:confirmed, 'true')
        flash[:notice] = "You are now collaborating with " + User.find(@collaborator.inviter_user_id).name + " on " + Mission.find(@collaborator.mission_id).name + "!"
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



