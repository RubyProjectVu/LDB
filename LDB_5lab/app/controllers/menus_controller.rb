class MenusController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def main
    redirect_to :controller => 'welcome', :action => 'index' unless params[:allowed]
  end
end
