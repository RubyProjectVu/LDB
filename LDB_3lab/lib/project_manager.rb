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
    File.open('projects.yml', 'w') do |fl|
      fl.write @projects.to_yaml.sub('---', '')
    end
    true
  end

  def save_project(project)
    pro = project
    return false if @projects.key?(project.data_getter('id'))
    File.open('projects.yml', 'a') do |fl|
      fl.write pro.to_hash.to_yaml.sub('---', '')
    end
    true
  end

  def load_project(id)
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
    @projects.each_key do |key|
      arr.push(key + ':' + @projects.fetch(key).fetch('name'))
    end
    arr
  end
end
