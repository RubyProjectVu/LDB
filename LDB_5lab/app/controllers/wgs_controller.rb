class WgsController < ApplicationController
  def index
    @projects = Project.where(manager: current_user['email'])
    if params[:method].eql?('create')
      create
    elsif params[:method].eql?('destroy')
      destroy
    end
  end

  def show
  end

  def new
  end

  def create
    if params[:wg]
      WorkGroup.create(projid: params[:wg][:projid], name: params[:wg][:name], budget: 0)
      wgr = WorkGroup.find_by(projid: params[:wg][:projid], name: params[:wg][:name])
      wgr.project_budget_setter(params[:wg][:budget].to_f)
    else
      render 'create'
    end
  end

  def edit
  end

  def update
  end

  def destroy
    wgr = WorkGroup.find_by(id: params[:id])
    wgr.project_budget_setter(0)
    WorkGroup.find_by(id: params[:id]).destroy
  end
end
