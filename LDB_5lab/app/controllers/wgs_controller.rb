class WgsController < ApplicationController
  def index
    @projects = Project.where(manager: current_user['email'])
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

  def addtsk
    render 'addtsk' unless params[:wg]
    if params[:wg]
      WorkGroup.find_by(id: params[:id]).add_group_task(params[:wg][:task])
    end
  end

  def remtsk
    WorkGroup.find_by(id: params[:id]).remove_group_task(params[:task])
  end

  def addmem
    render 'addmem' unless params[:wg]
    if params[:wg]
      WorkGroup.find_by(id: params[:id]).add_group_member(params[:wg][:member])
    end
  end

  def remmem
    WorkGroup.find_by(id: params[:id]).remove_group_member(params[:member])
  end

  def destroy
    wgr = WorkGroup.find_by(id: params[:id])
    wgr.project_budget_setter(0)
    WorkGroup.find_by(id: params[:id]).destroy
  end
end
