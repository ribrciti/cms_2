class AdminUsersController < ApplicationController

	layout 'admin'

	before_action :confirm_logged_in, except: [:login, :attempt_login, :logout]
  before_action :find_params, only: [:edit, :update, :delete]  
	
  def index
    @admin_users = AdminUser.sorted
  end

  def new
    @admin_user = AdminUser.new
  end

  def create
    @admin_user = AdminUser.new(admin_user_params)
    if @admin_user.save
      flash[:notice] = "Admin User succcessfully created."
      redirect_to action: "index"
    else
      flash[:notice] = "Admin User unsuccessfully created."
      redirect_to action: "new"      
    end
  end

  def edit    
  end

  def update
    if @admin_user.update_attributes(admin_user_params)
      flash[:notice] = "Admin User successfully Updated."
      redirect_to :action => "index"
    else
      render 'edit'
    end
  end

  def delete
  end

  def destroy
    admin_user = AdminUser.find(params[:id]).destroy
    flash[:notice] = " You have successfully deleted #{@admin_user.name}."
    redirect_to action: "index"
  end

  private

  def find_params
    @admin_user = AdminUser.find(params[:id])
  end

  def admin_user_params
    params.require(:admin_user).permit(:first_name, :last_name, :email, :username, :password, :created_at)
  end

end
