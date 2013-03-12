class CoactionsController < ApplicationController
    def index
        @mission = Mission.find(params[:mission_id])
        @coactions = @mission.coactions
        @collaborator = Collaborator.where(:user_id == current_user.id && :mission_id == @mission.id)
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
            # what about cleaing up the cross table? does it do it automatically?
            Coaction.find(params[:id]).stickies.delete(Sticky.where(:coaction_id => params[:id]))
            @coaction.destroy
            else
            flash[:notice] = "Can't delete unless it's yours or you have admin permission."
        end
        redirect_to mission_coactions_path(:mission_id => t_id)
    end
    
    def sort
        params[:coaction].each_with_index do |id, index|
            Coaction.update_all({position: index+1}, {id: id})
        end
        render nothing: true
    end
    
end
