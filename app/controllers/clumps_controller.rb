class ClumpsController < ApplicationController
    def create 
        @mission = Mission.find(params[:mission_id])
        @clump = @mission.clumps.new(params[:clump])
        @clump.user_id = current_user.id
        @clump.save

        redirect_to mission_clumps_path(:mission_id => @mission.id, :kind => params[:clump][:kind], :clump_id => @clump.id)
    end
    
    def destroy
        @mission = Mission.find(params[:mission_id])
        t_id = @mission.id
        @clump  = Clump.find(params[:id])
        c = Collaborator.where(:user_id => current_user.id, :mission_id => @clump.mission_id).first
        if (c.permission == 'creator' || c.permission == 'admin') || @clump.user_id == current_user.id then
            # make the stickies un-clumped from this clump about to be destroyed
            @stickies = Sticky.where(:clump_id => @clump.id)
            if @stickies then @stickies.each do  |sticky|
                sticky.clump_id = nil
                @sticky = sticky
                @sticky.save
            end end
            @clump.destroy
            else
            flash[:notice] = "Can't delete unless it's yours or you have admin permission."
        end
        redirect_to mission_clumps_path(:mission_id => t_id, :kind => @clump.kind)
    end
    
    def clear #haven't called this yet...
        @mission = Mission.find(params[:mission_id])
        t_id = @mission.id
        @clump  = Clump.find(params[:id])
        c = Collaborator.where(:user_id => current_user.id, :mission_id => @clump.mission_id).first
        if (c.permission == 'creator' || c.permission == 'admin' || c.permission == 'colleague') || @clump.user_id == current_user.id then
            # make the stickies un-clumped from this clump
            @stickies = Sticky.where(:clump_id => @clump.id)
            if @stickies then @stickies.each do  |sticky|
                sticky.clump_id = nil
                @sticky = sticky
                @sticky.save
            end
        end
            else
            flash[:notice] = "Can't clear this clump unless you are a collaborator."
        end
        redirect_to mission_clumps_path(:mission_id => t_id, :kind => @clump.kind)
    end
    
    def index
        @mission = Mission.find(params[:mission_id])
        @clumps = @mission.clumps
    end
    
    def edit
    end
    
    def update
        @mission = Mission.find(params[:mission_id])
        @clump = Clump.find(params[:clump][:id]) 
        @clump.name = params[:clump][:name]
        @clump.save
        redirect_to mission_clumps_path(:mission_id => @mission.id, :kind => @clump.kind, :clump_id => @clump.id)
    end
    
    def show
        @clump = Clump.find(params[:id])
        redirect_to mission_clumps_path(:mission_id => @mission.id, :kind => @clump.kind, :clump_id => @clump.id)
    end
    

end
