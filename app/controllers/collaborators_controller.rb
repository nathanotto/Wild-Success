class CollaboratorsController < ApplicationController
    def new
        #list the users available for collaboration because
        # either they collaborated in the past, or
        # they are collaborators of collaborators
        # they marked their user profiles as searchable and available for collaboration
        @users = User.all
        @mission = Mission.find(params[:mission_id])
        # @collaborators = @user.collaborators
        # add second-degree collaborator users: all the users who collaborated with my collaborators
        # NOTE this code so far only shows first-degree collaborators. MORE LATER
        ## @collaborators.each do |c|
        ##    mission = Mission.find(c.mission_id)
        ##    dtwo = Collaborators.where(:mission_id => mission.id)
        ##    dtwo.each do |user|
        ##        @users << User.find(dtwo.user_id)
        ##    end
        ##end
    end
    
    def create
        # This function will be given a list of proposed collaborators, who then
        # need to confirm that they are collaborating.
        # some collaborators are invited by email and don't have accounts
        # they will have accounts created when email is sent
        # the confirmation of the the email confirms both the user and the collaborator
        # ALL proposed collaborators will be sent emails
    end
end
