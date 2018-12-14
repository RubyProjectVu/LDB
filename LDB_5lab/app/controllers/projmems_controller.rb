class ProjmemsController < ApplicationController
  def index
    ProjectMember.find_by(projid: params.fetch(:id), member: params.fetch(:member)).destroy
  end
end
