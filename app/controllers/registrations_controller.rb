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
            c.user_id = User.all.last.id
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