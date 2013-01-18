class SuccessesController < ApplicationController
    def create
        @mission = Mission.find(params[:mission_id])
        @success = @mission.successes.create(params[:success])
        redirect_to mission_path(@mission)
    end
    
    def destroy
        @mission = Mission.find(params[:mission_id])
        @success  = @mission.successes.find(params[:id])
        @success.destroy
        redirect_to mission_path(@mission)
    end

end
