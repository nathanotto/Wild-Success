class DriversController < ApplicationController
    def create
        @mission = Mission.find(params[:mission_id])
        @driver = @mission.drivers.new(params[:driver])
        @driver.user_id = current_user.id
        @driver.save
        redirect_to mission_path(@mission)
    end
    
    def destroy
        @mission = Mission.find(params[:mission_id])
        @driver  = @mission.drivers.find(params[:id])
        c = Collaborator.where(:user_id => current_user.id, :mission_id => @driver.mission_id).first
        if (c.permission == 'creator' || c.permission == 'admin') || @driver.user_id == current_user.id then
            @driver.destroy
            else
            flash[:notice] = "Can't delete unless it's yours or you have admin permission."
        end
        redirect_to mission_path(@mission)
    end

end
