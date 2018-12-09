class ProjmemsController < ApplicationController
  def index
    ProjectMember.find_by(projid: params[:id], member: params[:member]).destroy
  end

  def show
  end

  def new
  end

  def addmem
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
