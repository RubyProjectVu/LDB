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

  def login
  end

  def parse_login
    raise params.inspect
  end
end
