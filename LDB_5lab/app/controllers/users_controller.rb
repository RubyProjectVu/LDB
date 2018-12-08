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
  end

  def parse_login
    result = UserManager.new.login(params[:email], params[:pass])
    redirect_to :controller=>'menus', :action=> 'main' if result

    flash[:error] = "Could not login: Incorrect credentials"
    redirect_to :controller => 'welcome', :action => 'index'
  end
end
