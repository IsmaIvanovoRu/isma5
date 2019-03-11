class GroupsController < ApplicationController
  load_and_authorize_resource
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :set_groups, only: [:index, :new, :edit]

  # GET /groups
  # GET /groups.json
  def index
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render action: 'show', status: :created, location: @group }
      else
        format.html { render action: 'new' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end
  
  def add_to
    Group.find(params[:id]).users << User.find(params[:user_id])
    redirect_to :back
  end
  
  def remove_from
    Group.find(params[:id]).users.delete(User.find(params[:user_id]))
    redirect_to :back
  end
  
  def current_ability
    @current_ability ||= GroupAbility.new(current_user)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.includes(:profiles).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :administrator, :moderator, :writer, :reader, :commentator, :parent_id)
    end
    
    def set_groups
      @groups = Group.all
    end
end
