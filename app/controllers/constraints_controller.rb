class ConstraintsController < ApplicationController
    def create
        @mission = Mission.find(params[:mission_id])
        @constraint = @mission.constraints.create(params[:constraint])
        redirect_to mission_path(@mission)
    end
    
    def destroy
        @mission = Mission.find(params[:mission_id])
        @constraint  = @mission.constraints.find(params[:id])
        @constraint.destroy
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
