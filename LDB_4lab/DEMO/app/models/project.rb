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
    ProjectMember.find_by projid: self.id
  end

  def data_getter(key)
    case key
    when 'name'
      return Project.find_by(id: self.id).name
    when 'manager'
      return Project.find_by(id: self.id).manager
    end
  end

  def data_setter(key, val)
    case key
    when 'name'
      proj = Project.find_by(id: self.id)
      proj.name = val
    when 'manager'
      proj = Project.find_by(id: self.id)
      proj.manager = val
    end
    proj.save
  end

  def parm_project_status(status = '')
    if !status.empty?
      if ['Proposed', 'Suspended', 'Postponed',
          'Cancelled', 'In progress'].include? status
        proj = Project.find_by(id: self.id)
        proj.status = status
        proj.save
      end
    else
      Project.find_by(id: self.id).status
    end
  end

  def add_member(mail)
    ProjectMember.create(projid: self.id, member: mail)
    true
  end

  def remove_member(mail)
    pm = ProjectMember.find_by(projid: self.id, member: mail)
    pm.destroy
    true
  end

  def set_deleted_status
    if Project.find_by(id: self.id).status.eql?('Deleted')
      false
    else
      proj = Project.find_by(id: self.id)
      proj.status = 'Deleted'
      proj.save
      true
    end
  end
end
