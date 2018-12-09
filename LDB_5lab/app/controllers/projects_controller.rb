class ProjectsController < ApplicationController
  def index
    @projects = Project.where(manager: current_user['email'])
    if params[:method].eql?('create')
      create
    elsif params[:method].eql?('destroy')
      destroy
    elsif params[:method].eql?('edit')
      edit
    end
  end

  def show
  end

  def new
  end

  def create
    if params[:project]
      Project.create(name: params[:project][:name], manager: params[:project][:manager], status: params[:project][:status], budget: params[:project][:budget])
    else
      render 'create'
    end
  end

  def edit
    render 'edit'
  end

  def update
    proj = Project.find_by(params[:project][:id])
    proj.project_status_setter(params[:project][:status])
    proj.name = params[:project][:name]
    proj.manager = params[:project][:manager]
    proj.save
    BudgetManager.new.budgets_setter(params[:project][:id], params[:project][:budget])
  end

  def destroy
    Project.find_by(params[:id]).destroy
  end
end
