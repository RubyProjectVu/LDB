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
    return false if @projects.key?(project.data_getter('id'))

    hash = project.to_hash
    File.open('projects.yml', 'a') { |fl| fl.write hash.to_yaml.sub('---', '') }
    true
  end

  def load_project(id)
    return false unless @projects.key?(id)
    proj = @projects.fetch(id)
    obj = Project.new(project_name: proj.fetch('name'),
                      manager: proj.fetch('manager'), num: id,
                      members: proj.fetch('members'))
    obj.parm_project_status(proj.fetch('status'))

    obj
  end

  # TODO: placeholder - will be implemented later
  def active_projects_present?
    false
  end

  def list_projects
    arr = []
    IO.foreach('projects.yml') do |line|
      if line.start_with?('  name:')
        arr.push(line[8..-1])
      end
    end
  arr
  end
end
