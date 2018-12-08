class UsersController < ApplicationController
  # helper_method :login -?

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def parse_signup
    result = UserManager.new.register([params[:user][:name], params[:user][:lname]], params[:user][:email], params[:user][:pass])
  end

  def parse_login
    result = UserManager.new.login(params[:user][:email], params[:user][:pass])
    redirect_to :controller=>'menus', :action=> 'main', :allowed => true and return if result

    flash[:error] = "Could not login: Incorrect credentials"
    redirect_to :controller => 'welcome', :action => 'index'
  end
end
