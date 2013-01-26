class CollaboratorsController < ApplicationController
    /* #need to learn how to do this code.
    
    def create #create a new collaborator for a mission. Need to still set this up as "request collaboration on this mission" when looking at a list of users or user profile of another user. So need boolean 'confirmed'. Creates a new collaboration automatically with a new mission with type set to "creator" -- need to put that in mission_controller#create
        @mission = Mission.find(params[:mission_id])
        @user = User.find(session[:user_id])
        @collaborator  = @mission.collaborators.create(params[:collaborator])
        redirect_to edit_mission_path(@mission)
    end
    
    def destroy # delete a collaborator from a mission
        @mission = Mission.find(params[:mission_id])
        @driver  = @mission.drivers.find(params[:id])
        @driver.destroy
        redirect_to mission_path(@mission)
    end
   */

end
