class SuccessesController < ApplicationController
    def create
        @mission = Mission.find(params[:mission_id])
        @success = @mission.successes.new(params[:success])
        @success.user_id = current_user.id
        @success.save
        redirect_to mission_path(@mission)
    end
    
    def destroy
        @mission = Mission.find(params[:mission_id])
        @success  = @mission.successes.find(params[:id])
        c = Collaborator.where(:user_id => current_user.id, :mission_id => @success.mission_id).first
        if (c.permission == 'creator' || c.permission == 'admin') || @success.user_id == current_user.id then
            @success.destroy
        else
            flash[:notice] = "Can't delete unless it's yours or you have admin permission."
        end
        redirect_to mission_path(@mission)
    end

end
