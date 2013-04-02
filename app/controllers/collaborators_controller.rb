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
        # This function will be given a list of proposed collaborators, who then
        # need to confirm that they are collaborating.
        # collaboration invitations show up on users screens with confirmations
        # some collaborators are invited by email and don't have accounts
        # email links will create the accounts and generate the collaborations
        # the confirmation of the the email confirms the user, then the collaborator is confirmed
        # on the home index screen of the user.
        # ALL proposed collaborators will be sent emails
        @mission = Mission.find(params[:mission_id])
        @user = User.find(current_user.id)
        # first, email the existing users
        names_string = " "
        name_count = 0
        bad_emails = " "
        bad_email_count = 0
        if params[:mission].present? then
            params[:mission][:user_ids].each do |id|
                user = User.find(id)
                names_string = names_string + user.email + ", "
                name_count += 1
                # make new collaborator here: mission, user_id, inviter_user_id
                c_new = Collaborator.new
                c_new.user_id = user.id
                c_new.inviter_user_id = @user.id
                c_new.permission = 'colleague'
                c_new.mission_id = @mission.id
                c_new.confirmed = 'f'
                c_new.can_invite = 'f' # refinement: let this be a parameter set by admins and owners
                c_new.save
                # send email here
                CollaboratorMailer.existing_user_invite(user, @user, @mission).deliver
            end
        end
        if params[:collaborator].present? then # then there is a list of emails there to process
            emails = params[:collaborator][:email_list].split(",")
            # verify each email is valid enough and throw away the baddies
            emails.each do |em|
                if em =~ /@/ then
                    names_string = names_string + em + ", "
                    name_count += 1
                    CollaboratorMailer.new_user_invite(em, @user, @mission).deliver
                else
                    bad_emails = bad_emails + em + ", "
                    bad_email_count += 1
                end
            end
        end 
        # $param = params
        # trim the last "," off of names_string here and bad_emails
        if bad_email_count > 0 then
            names_string = names_string + " and couldn't send to: " + bad_emails
        end 
        # redirect_to @mission, notice: "Emailed invitations to #{names_string}."
        if name_count < 1 then names_string = "No invitations sent. ,"
            else
            names_string = "Emailed invitations to " + names_string + "."
        end 
        names_string = names_string[0..-4] + '.'
        redirect_to mission_stickies_path(@mission, :kind => 'success'), notice: names_string
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



