class UsersController < ApplicationController
  before_action :admin_users?
  def index
    @users = User.paginate(page: params[:page])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash.now[:danger] = "Undefined user."
    elsif @user.update_columns(role: params[:value])
      flash[:success] = "Updated role"
    else
      flash.now[:danger] = "Cannot update user."
    end
    redirect_back(fallback_location: :fallback_location)

  end

  def destroy
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash.now[:danger] = "Undefined user."
    elsif @user.destroy
      flash[:success] = "Delete user"
    else
      flash.now[:danger] = "Cannot delete user."
    end
    redirect_back(fallback_location: :fallback_location)

  end

  private
end
