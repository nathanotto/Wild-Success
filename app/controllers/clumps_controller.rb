class ClumpsController < ApplicationController
    def create # couldn't pass the :kind param, or find documentation, trying deprecated method of global variabe
        @mission = Mission.find(params[:mission_id])
        @clump = @mission.clumps.new(params[:clump])
        @clump.user_id = current_user.id
        @clump.kind = $kind
        @clump.save

        redirect_to mission_clumps_path(:mission_id => @mission.id, :kind => $kind, :clump_id => @clump.id)
    end
    
    def destroy
        @mission = Mission.find(params[:mission_id])
        t_id = @mission.id
        @clump  = @mission.clumps.find(params[:id])
        c = Collaborator.where(:user_id => current_user.id, :mission_id => @clump.mission_id).first
        if (c.permission == 'creator' || c.permission == 'admin') || @clump.user_id == current_user.id then
            @clump.destroy
            else
            flash[:notice] = "Can't delete unless it's yours or you have admin permission."
        end
        redirect_to mission_clumps_path(:mission_id => t_id, :kind => $kind)
    end
    
    def index
        @mission = Mission.find(params[:mission_id])
        @clumps = @mission.clumps
    end
    
    def edit
    end
    
    def update
    end
    

end
