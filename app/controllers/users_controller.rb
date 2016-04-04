class UsersController < ApplicationController
  def edit
    @user = User.first
  end
end
