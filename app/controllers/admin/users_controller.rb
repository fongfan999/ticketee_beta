class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :archive]

  def index
  	@users = User.excluding_archived.order(:email)
  end

  def show
  end

  def edit
  end

  def archive
    if @user == current_user
      flash[:alert] = "You cannot archive yourself!"
    else
      @user.archive
      flash[:notice] = "User has been archived."
    end
    
    redirect_to admin_users_path
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)

  	if @user.save
  		flash[:notice] = "User has been created."
  		redirect_to admin_users_path
  	else
  		flash[:alert] = "User has not been created."
  		render "new"
  	end
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
    end

    if @user.update(user_params)
      flash[:notice] = "User has been updated."
      redirect_to admin_users_path
    else
      flash[:alert] = "User has noot been updated."
      render "edit"
    end
  end

  private

  def user_params
  	params.require(:user).permit(:email, :password, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
