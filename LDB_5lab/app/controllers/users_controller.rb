class UsersController < ApplicationController
  # helper_method :login -?
  before_action :auth_user, except: [:login, :parse_login, :create, :parse_signup]

  def auth_user
    redirect_to :controller => 'welcome', :action => 'index' unless user_signed_in?
  end

  def index
    if params[:method].eql?('edit')
      edit
    elsif params[:method].eql?('destroy')
      destroy
    end
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    if params[:user]
      UserManager.new.register([params[:user][:name], params[:user][:lname]], params[:user][:email], params[:user][:pass])
    end
  end

  def edit
    render 'edit'
  end

  def update
    usr = User.find_by(email: current_user['email'])
    usr.name = params[:user][:name]
    usr.lname = params[:user][:lname]
    usr.password_set(params[:user][:pass])
    usr.save
  end

  def destroy
    UserManager.new.delete_user(current_user['email'])
  end

  def parse_signup
  end

  def parse_login
    result = UserManager.new.login(params[:user][:email], params[:user][:pass])
    if result
      @user = User.find_by(email: params[:user][:email])
      sign_in(@user)
      #redirect_to :controller=>'menus', :action=> 'main' and return
      redirect_to :controller => :projects, :method => :index and return
    end

    flash[:error] = "Could not login: Incorrect credentials"
    redirect_to :controller => 'welcome', :action => 'index'
  end
end
