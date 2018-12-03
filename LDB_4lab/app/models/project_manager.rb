# frozen_string_literal: true

require 'date'
require 'etc'
require_relative 'project'
require './application_record'
require 'yaml'
require 'net/http'
require 'uri'

# rubocop comment?
class ProjectManager
  def initialize
    @state = true
  end

  def set_project_description(project)
    uri = URI('https://geek-jokes.sameerkumar.website/api')
    generatedText = Net::HTTP.get(uri)
    project.description = generatedText
    save
    generatedText
  end

  def delete_project(project)
    proj = Project.find_by(id: project)
    proj.destroy
    @state
  end

  def save_project(name, manager)
    return false unless @state

    Project.create(name: name, manager: manager)
    true
  end

  def load_project(id)
    proj = projo = projt = projf = Project.find_by(id: id)
    return false unless proj && @state

    # will return a collection of attributes here
    [projf.name, proj.manager, projt.status, projo.budget]
  end

  # TODO: placeholder - will be implemented later
  def active_projects_present?
    false
  end

  def list_projects
    return false unless @state

    arr = []
    Project.all.ids.each do |pj|
      arr.push(pj.to_s + ':' + (Project.find_by id: pj).name)
    end

    arr
  end

  def load_projects_and_members
    prj_mem = {}
    ProjectMember.all.each { |memb|
      if prj_mem.has_key?(memb.projid)
        prj_mem[memb.projid] += 1
      else
        prj_mem[memb.projid] = 1
      end
    }
    prj_mem
  end
end
