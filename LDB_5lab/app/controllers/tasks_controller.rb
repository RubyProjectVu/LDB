class TasksController < ApplicationController
  def index
    @tasks = Task.all
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
    if params[:task]
      Task.create(task: params[:task][:task])
    else
      render 'create'
    end
  end

  def edit
  end

  def update
  end

  def destroy
    Task.find_by(task: params[:task]).destroy
  end
end
