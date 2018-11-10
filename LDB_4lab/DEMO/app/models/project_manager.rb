# frozen_string_literal: true

require 'date'
require 'etc'
require_relative 'project'
require './application_record'
require 'yaml'

# rubocop comment?
class ProjectManager
  #def initialize
   # @projects = YAML.load_file('projects.yml')
  #end

  def delete_project(project)
    proj = Project.find_by projid: project
    proj.destroy
    true
  end

  def save_project(name, manager)
    Project.create(name: name, manager: manager)
    true
  end

  def load_project(id)
    proj = Project.find_by id: id
    # will return a collection of attributes here
    return false unless @projects.key?(id)
    proj = projo = @projects.fetch(id)
    obj = Project.new(project_name: proj.fetch('name'),
                      manager: proj.fetch('manager'), num: id,
                      members: projo.fetch('members'))
    obj.parm_project_status(projo.fetch('status'))

    obj
  end

  # TODO: placeholder - will be implemented later
  def active_projects_present?
    false
  end

  def list_projects
    arr = []
    lofids = Project.all.ids
    lofids.each do |t|
      arr.push(t + ':' + (Project.find_by id: t).name)
    end

    #@projects.each_key do |key|
     # arr.push(key + ':' + @projects.fetch(key).fetch('name'))
    #end
    arr
  end
end
