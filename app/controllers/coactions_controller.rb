class CoactionsController < ApplicationController
    def index
        @mission = Mission.find(params[:mission_id])
        @coactions = @mission.coactions
    end
    
    def create
        @mission = Mission.find(params[:mission_id])
        @coaction = @mission.coactions.new(params[:coaction])
        @coaction.user_id = current_user.id
        @coaction.save
        
        redirect_to mission_coactions_path(:mission_id => @mission.id, :coaction_id => @coaction.id)
    end
    
    def destroy
        @mission = Mission.find(params[:mission_id])
        t_id = @mission.id
        @coaction  = Coaction.find(params[:id])
        c = Collaborator.where(:user_id => current_user.id, :mission_id => @mission.id).first
        if (c.permission == 'creator' || c.permission == 'admin') || @coaction.user_id == current_user.id then
            # make the stickies un-clumped from this clump about to be destroyed
            @stickies = Sticky.where(:coaction_id => @coaction.id)
            if @stickies then @stickies.each do  |sticky|
                sticky.coaction_id = nil
                @sticky = sticky
                @sticky.save
            end end
            @coaction.destroy
            else
            flash[:notice] = "Can't delete unless it's yours or you have admin permission."
        end
        redirect_to mission_coactions_path(:mission_id => t_id)
    end

    
    
end
