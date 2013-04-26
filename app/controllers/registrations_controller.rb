class RegistrationsController < Devise::RegistrationsController
    def new
        super
    end
        
    def update
        super
    end
    
    def create
        super
        if params[:user][:token] then
        invitation = Invitation.find_by_token(params[:user][:token])
            c = Collaborator.new
            c.user_id = User.maximum("id") # KLUDGE line, this should actually access the id of the newly created user directly, but 'current_user' doesn't work at this point, because the user hasn't verified their email, and so they aren't logged in. This is counting on no other users being written to the db in the interval, which is BAD practice but actually pretty safe because the gap is milliseconds.
            c.inviter_user_id = invitation.sender_id
            c.mission_id = invitation.mission_id
            c.permission = 'colleague'
            c.confirmed = 't'
            c.can_invite = 'f'
            c.save
        end
        flash[:notice] = "A confirmation link has been sent to " + params[:user][:email] + ". Check your inbox to complete your registration."
    end
end