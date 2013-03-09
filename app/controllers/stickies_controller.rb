class StickiesController < ApplicationController
    def create
        @mission = Mission.find(params[:mission_id])
        @sticky  = @mission.stickies.new(params[:sticky])
        @sticky.user_id = current_user.id
        @sticky.position = 0
        @sticky.save 
        redirect_to mission_path(@mission) + '#' + @sticky.kind.pluralize
    end
    
    def destroy
        @mission = Mission.find(params[:mission_id])
        @sticky  = @mission.stickies.find(params[:id])
        c = Collaborator.where(:user_id => current_user.id, :mission_id => @sticky.mission_id).first
        if (c.permission == 'creator' || c.permission == 'admin') || @sticky.user_id == current_user.id then
            @sticky.destroy
            
        else
            flash[:notice] = "Can't delete unless it's yours or you have admin permission."
        end
        redirect_to mission_path(@mission)
    end
    
    def clump
         if params[:add_to_clump] == 'true' then  
         @sticky = Sticky.find(params[:sticky_id]) 
         @sticky.clump_id = params[:clump_id] 
         @sticky.save 
         end
         else
            if params[:add_to_clump] == 'remove' then 
            @sticky = @sticky.find(params[:sticky_id]) 
            @sticky.clump_id = nil 
            @sticky.save 
        end 
    end
    
    def sort
        params[:sticky].each_with_index do |id, index|
            Sticky.update_all({position: index+1}, {id: id})
        end
        render nothing: true
    end
    
end



