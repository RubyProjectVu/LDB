class UserManagersController < ApplicationController
  def new
    @user_manager = UserManager.new
  end
end
