# frozen_string_literal: true

# Manages project data control
class ProjectsController < ApplicationController
  def index
    @projects = Project.where(manager: current_user['email'])
  end

  def addmem
    return unless params.key?(:project)

    Project.find_by(id: params.fetch(:id))
           .add_member(params.fetch(:project).fetch(:member))
  end

  def create
    if params.key?(:project)
      hash = params.fetch(:project)
      Project.create(name: hash.fetch(:name),
                     manager: hash.fetch(:manager),
                     status: hash.fetch(:status),
                     budget: hash.fetch(:budget))
    end
  end

  def bdgts
    BudgetManager.new.budgets_setter(params.fetch(:project).fetch(:id),
                                     params.fetch(:project).fetch(:budget))
  end

  def stts_nm_mngr(pro)
    pro.project_status_setter(params.fetch(:project).fetch(:status))
    pro.name = params.fetch(:project).fetch(:name)
    pro.manager = params.fetch(:project).fetch(:manager)
    bdgts
  end

  def update
    return unless params.key?(:project)

    pro = Project.find_by(id: params.fetch(:project).fetch(:id))
    stts_nm_mngr(pro)
    pro.save
  end

  def destroy
    Project.find_by(id: params.fetch(:id)).destroy
  end
end
