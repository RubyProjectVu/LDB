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
      fl.write @projects.to_yaml.sub('---', '').sub('{}', '')
    end
    true
  end

  def save_project(project)
    pro = project
    return false unless [nil].include?(@projects[project.data_getter('id')])
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

  def add_member_to_project(member, project_id)
    project = load_project(project_id)
    project.add_member(member)
    delete_project(Project.new(num: project_id))
    save_project(project)
  end

  def remove_member_from_project(member, project_id)
    project = load_project(project_id)
    project.remove_member(member)
    delete_project(Project.new(num: project_id))
    save_project(project)
  end

  def set_project_status(project_id, status)
    project = load_project(project_id)
    return false unless project.parm_project_status(status)

    delete_project(Project.new(num: project_id))
    save_project(project)
    true
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
