class ConstraintsController < ApplicationController
    def create
        @mission = Mission.find(params[:mission_id])
        @constraint = @mission.constraints.new(params[:constraint])
        @constraint.user_id = current_user.id
        @constraint.save
        redirect_to mission_path(@mission)
    end
    
    def destroy
        @mission = Mission.find(params[:mission_id])
        @constraint  = @mission.constraints.find(params[:id])
        c = Collaborator.where(:user_id => current_user.id, :mission_id => @constraint.mission_id).first
        if (c.permission == 'creator' || c.permission == 'admin') || @constraint.user_id == current_user.id then
            @constraint.destroy
            else
            flash[:notice] = "Can't delete unless it's yours or you have admin permission."
        end
        redirect_to mission_path(@mission)
    end

end


# def create
#    @mission = Mission.find(params[:mission_id])
#    @driver = @mission.drivers.create(params[:driver])
#    redirect_to mission_path(@mission)
# end

#
#    def destroy
#        @mission = Mission.find(params[:mission_id])
#       @driver  = @mission.drivers.find(params[:id])
#        @driver.destroy
#       redirect_to mission_path(@mission)
#    end
#
# end
