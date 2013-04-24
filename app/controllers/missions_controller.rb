class MissionsController < ApplicationController
    before_filter :authenticate_user!
    
  # GET /missions
  # GET /missions.json
  def index
      # The right way to do this is with user has_many missions through collaborators. Couldn't get the routes or models to work, so I did it this klugy way insted. ideally, @missions = @user.missions.
    
      @collaborators = Collaborator.where(:user_id => current_user.id)
      if @collaborators[0] then @missions = Mission.where( :id => @collaborators[0].mission_id)
      for i in 1..(@collaborators.length-1)
       @missions = @missions + Mission.where( :id => @collaborators[i].mission_id)
          end
        end     
          
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @missions }
    end
  end

    # GET need to add route here to public missions, paginate the view
    def index_pubic
      @missions = @missions + Mission.where(:is_public => true)
      respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @missions }

      end
    end 
      
  # GET /missions/1
  # GET /missions/1.json
  def show
    @mission = Mission.find(params[:id])
    @collaborator = Collaborator.where(:mission_id => @mission.id, :user_id => current_user.id).first
    if @collaborator then
        @stickies = @mission.stickies
      else
      flash[:notice] = "You don't have permission to access the mission."
      redirect_to missions_path
    end 
  end
    
  # GET /missions/plan  need to add route for /missions/plan
    def finish
        @mission = Mission.find(params[:id])
        @stickies = @mission.stickies
        @clumps = @mission.clumps
        @coactions = @mission.coactions
        
        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @mission }
        end
    end

    
  # GET /missions/new
  # GET /missions/new.json
  def new
    @mission = Mission.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mission }
    end
  end

  # GET /missions/1/edit
  def edit
      @mission = Mission.find(params[:id])
      @collaborator = Collaborator.where(:mission_id => @mission.id, :user_id => current_user.id)
      unless @collaborator.first.permission == ('creator' ||  'admin' )
          flash[:notice] = "You don't have creator or admin permission to edit this mission."
          redirect_to missions_url
          end
  end

  # POST /missions
  # POST /missions.json
  def create
      @mission = Mission.new(params[:mission])
      @mission.save
      # Set the current user to 'creator' with a new entry in Collaborators:
      @collaborator = Collaborator.new(:user_id => current_user.id, :mission_id => @mission.id, :permission => 'creator', :confirmed => true, :inviter_user_id => current_user.id)
      @collaborator.save
      
    respond_to do |format|
      if @mission.save
        format.html { redirect_to new_mission_invitation_path(@mission), notice: 'Mission was successfully created.' }
        format.json { render json: @mission, status: :created, location: @mission }
      else
        format.html { render action: "new" }
        format.json { render json: @mission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /missions/1
  # PUT /missions/1.json
  def update
    @mission = Mission.find(params[:id])

    respond_to do |format|
      if @mission.update_attributes(params[:mission])
        format.html { redirect_to @mission, notice: 'Mission was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /missions/1
  # DELETE /missions/1.json NOTE: need to clean up Collaborators here
  def destroy
    @mission = Mission.find(params[:id])
    @mission.collaborators.destroy
    @mission.destroy

    respond_to do |format|
      format.html { redirect_to missions_url }
      format.json { head :no_content }
    end
  end
end
