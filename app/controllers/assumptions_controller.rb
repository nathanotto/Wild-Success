class AssumptionsController < ApplicationController
    def create
        @mission = Mission.find(params[:mission_id])
        @assumption = @mission.assumptions.create(params[:assumption])
        redirect_to mission_path(@mission)
    end
    
    def destroy
        @mission = Mission.find(params[:mission_id])
        @assumption  = @mission.assumptions.find(params[:id])
        @assumption.destroy
        redirect_to mission_path(@mission)
    end

end
