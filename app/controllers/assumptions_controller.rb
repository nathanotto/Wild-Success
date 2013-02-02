class AssumptionsController < ApplicationController
    def create
        @mission = Mission.find(params[:mission_id])
        @assumption = @mission.assumptions.new(params[:assumption])
        @assumption.user_id = current_user.id
        @assumption.save
        redirect_to mission_path(@mission)
    end
    
    def destroy
        @mission = Mission.find(params[:mission_id])
        @assumption  = @mission.assumptions.find(params[:id])
        c = Collaborator.where(:user_id => current_user.id, :mission_id => @assumption.mission_id).first
        if (c.permission == 'creator' || c.permission == 'admin') || @assumption.user_id == current_user.id then
            @assumption.destroy
            else
            flash[:notice] = "Can't delete unless it's yours or you have admin permission."
        end
        redirect_to mission_path(@mission)
    end

end
