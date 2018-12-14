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
    WorkGroup.find_by(id: params.fetch(:id)).add_group_task(params.fetch(:wg).fetch(:task))
  end

  def remtsk
    WorkGroup.find_by(id: params.fetch(:id)).remove_group_task(params.fetch(:task))
  end

  def addmem
    if params.key?(:wg)
      WorkGroup.find_by(id: params.fetch(:id)).add_group_member(params.fetch(:wg).fetch(:member))
    end
  end

  def remmem
    WorkGroup.find_by(id: params.fetch(:id)).remove_group_member(params.fetch(:member))
  end

  def destroy
    wgr = WorkGroup.find_by(id: params.fetch(:id))
    wgr.project_budget_setter(0)
    WorkGroup.find_by(id: params.fetch(:id)).destroy
  end
end
