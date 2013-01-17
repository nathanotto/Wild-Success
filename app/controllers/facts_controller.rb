class FactsController < ApplicationController
    def create
        @mission = Mission.find(params[:mission_id])
        @fact = @mission.facts.create(params[:fact])
        redirect_to mission_path(@mission)
    end
    
    def destroy
        @mission = Mission.find(params[:mission_id])
        @fact  = @mission.facts.find(params[:id])
        @fact.destroy
        redirect_to mission_path(@mission)
    end

end
