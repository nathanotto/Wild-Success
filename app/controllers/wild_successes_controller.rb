class WildSuccessesController < ApplicationController
    def create
        @mission = Mission.find(params[:mission_id])
        @wild_success = @mission.wild_successes.create(params[:wild_success])
        redirect_to mission_path(@mission)
    end
    
    def destroy
        @mission = Mission.find(params[:mission_id])
        @wild_success = @mission.wild_successes.find(params[:id])
        @wild_success.destroy
        redirect_to mission_path(@mission)
    end
        
end

