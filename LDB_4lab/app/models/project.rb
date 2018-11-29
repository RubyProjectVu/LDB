# frozen_string_literal: true

require 'date'
require 'etc'
require './application_record'
require_relative 'project_member'
srand 0

# rubocop comment?
class Project < ApplicationRecord
  has_many :project_members

  def members_getter
    arr = []
    list = ProjectMember.where(projid: id)
    list.each do |t|
      arr.push(t.member)
    end
    arr
  end

  def data_setter(key, val)
    case key
    when 'name'
      proj = Project.find_by(id: id)
      proj.name = val
    when 'manager'
      proj = Project.find_by(id: id)
      proj.manager = val
    end
    proj.save
  end

  # Only setter. Getting status is simply Project.find_by().status
  def project_status_setter(status)
    if ['Proposed', 'Suspended', 'Postponed',
        'Cancelled', 'In progress'].include? status
      proj = Project.find_by(id: id)
      proj.status = status
      proj.save
    else
      false
    end
  end

  def add_member(mail)
    ProjectMember.create(projid: id, member: mail)
    true
  end

  def remove_member(mail)
    pm = ProjectMember.find_by(projid: id, member: mail)
    return false if [nil].include?(pm)

    pm.destroy
    true
  end

  def set_deleted_status
    if Project.find_by(id: id).status.eql?('Deleted')
      exec_deleted_status
      false
    else
      proj = Project.find_by(id: id)
      proj.status = 'Deleted'
      proj.save
      true
    end
  end

  def exec_deleted_status
    ProjectManager.new.delete_project(id)
  end
end
