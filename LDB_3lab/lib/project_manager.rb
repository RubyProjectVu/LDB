# frozen_string_literal: true

require 'date'
require 'etc'
require_relative 'project'
require 'yaml'

# rubocop comment?
class ProjectManager
  def initialize
    @projects = YAML.load_file('projects.yml')
  end

  def delete_project(project)
    @projects.delete(project.data_getter('id'))
    File.open('projects.yml', 'w') { |fl| fl.write @projects.to_yaml.sub('---', '') }
  end

  def create_project(project)
    return false if @projects.key?(project.parm_id)

    hash = project.to_hash
    File.open('projects.yml', 'a') { |fl| fl.write hash.to_yaml.sub('---', '') }
  end

  def load_project(id)
    return false unless @projects.key?(id)
    proj = @projects.fetch(id)
    obj = Project.new(project_name: proj.fetch('name'), manager: proj.fetch('manager'), num: id, members: proj.fetch('members'))
    obj.parm_project_status(proj.fetch('status'))
    
    return obj
  end
end