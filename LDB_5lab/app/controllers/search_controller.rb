class SearchController < ApplicationController
  def index
  end

  def show
    @result = Search.new.search_by_criteria([params[:usr], params[:proj], params[:wgs], params[:tsk], params[:note], params[:ordr]], params[:search][:value])
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
end
