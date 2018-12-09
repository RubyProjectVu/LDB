class SearchController < ApplicationController
  def index
  end

  def show
    crit = []
    all = %w[usr proj wgs tsk note ordr]
    all.each do |val|
      crit.push(params[val.to_sym]) unless [nil, ''].include?(params[val.to_sym])
    end
    # @result = Search.new.search_by_criteria([params[:usr], params[:proj], params[:wgs], params[:tsk], params[:note], params[:ordr]], params[:search][:value])
    @result = Search.new.search_by_criteria(crit, params[:search][:value])
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
