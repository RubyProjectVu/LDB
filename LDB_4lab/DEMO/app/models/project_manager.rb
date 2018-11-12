# frozen_string_literal: true

require 'date'
require 'etc'
require_relative 'project'
require './application_record'
require 'yaml'

# rubocop comment?
class ProjectManager
  def delete_project(project)
    proj = Project.find_by(id: project)
    proj.destroy
    true
  end

  def save_project(name, manager)
    Project.create(name: name, manager: manager)
    true
  end

  def load_project(id)
    proj = Project.find_by(id: id)
    return false if [nil].include?(proj)
    # will return a collection of attributes here
    [proj.name, proj.manager, proj.status, proj.budget]
  end

  # TODO: placeholder - will be implemented later
  def active_projects_present?
    false
  end

  def list_projects
    arr = []
    lofids = Project.all.ids
    lofids.each do |t|
      arr.push(t.to_s + ':' + (Project.find_by id: t).name)
    end

    arr
  end
end
