class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def create
    if params.key?(:task)
      Task.create(task: params.fetch(:task).fetch(:task))
    end
  end

  def destroy
    Task.find_by(task: params.fetch(:task)).destroy
  end
end
