class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: [:show]
  before_action :user_params
  
  def index
    @users = User.select(:id, :login).includes(:groups, :profile).order('profiles.updated_at DESC').where(profiles: user_params).paginate(page: params[:page])
    @all_users = User.select(:id, :login).order(:login).includes('profile')
    respond_to do |format|
      format.html
#       format.xls
    end
  end

  def show
    redirect_to user_profile_path(@user)
  end

  def import
    User.import(params[:file])
    redirect_to users_url, notice: "Users imported."
  end
  
  def current_ability
    @current_ability ||= UserAbility.new(current_user)
  end
  
  private
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.permit(:published)
  end
end
