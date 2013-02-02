class FactsController < ApplicationController
    def create
        @mission = Mission.find(params[:mission_id])
        @fact = @mission.facts.new(params[:fact])
        @fact.user_id = current_user.id
        @fact.save
        redirect_to mission_path(@mission)
    end
    
    def destroy
        @mission = Mission.find(params[:mission_id])
        @fact  = @mission.facts.find(params[:id])
        c = Collaborator.where(:user_id => current_user.id, :mission_id => @fact.mission_id).first
        if (c.permission == 'creator' || c.permission == 'admin') || @fact.user_id == current_user.id then
            @fact.destroy
            else
            flash[:notice] = "Can't delete unless it's yours or you have admin permission."
        end
        redirect_to mission_path(@mission)
    end

end
