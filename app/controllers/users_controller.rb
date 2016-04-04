class UsersController < ApplicationController
  before_action :authenticate_user

  def edit
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      flash[:notice] = 'Successfully updated preferences. Enjoy!'
    else
      flash[:notice] = 'Something went wrong. Please try again.'
    end

    redirect_to edit_user_path(@user)
  end

  private

    def authenticate_user
      @user = User.find(params[:id])
      return redirect_to root_path unless session[:digits_id] == @user.digits_id
    end

    def user_params
      params.require(:user).permit(:frequency)
    end
end
