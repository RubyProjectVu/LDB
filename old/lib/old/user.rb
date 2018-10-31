# frozen_string_literal: true

require 'securerandom' # random hash kuriantis metodas yra
require_relative 'project'
require_relative 'system'
require_relative 'work_group'
require 'uri'

# Documentation about class User
class User
  def initialize(name: '', last_name: '', email: '')
    @info = { name: name, lname: last_name, email: email,
              pass: '123', lobject: '' }
    @projects = {}
  end

  def data_getter(key)
    @info.fetch(key.to_sym)
  end

  def register
    mailing = data_getter('email')
    hash = { mailing => { 'name' => data_getter('name'),
                          'lname' => data_getter('lname'),
                          'pwd' => data_getter('pass') } }
    return true if System.new.users_push(mailing, hash)

    false
  end

  def delete_user
    System.new.users_pop(data_getter('email'))
  end

  def prepare_deletion
    return true unless active_projects_present?

    false
  end

  def active_projects_present?
    @projects.each_value do |status|
      return true if status.eql? 'In progress'
    end
    false
  end

  def add_project(project, status)
    # should ideally determine if project manager approves first
    @projects[project] = status
  end

  def create_project(project_name, file_name)
    @info[:lobject] = 'Project'
    Project.new(project_name: project_name, meta_filename: file_name)
  end

  def projects_getter
    @projects
  end

  def create_work_group(work_group_name)
    @info[:lobject] = 'WGroup'
    WorkGroup.new(work_group_name: work_group_name)
  end

  def upload_certificate(file)
    @info['lobject'] = Regexp.new('([a-zA-Z0-9_.\-])+(.doc|.docx|.pdf)$')
    return true if @info.fetch('lobject').match?(file)

    false
  end

  def password_set(new)
    # should later (5 laboras) work based on Rails gem 'EmailVeracity'
    @info[:pass] = new
  end
end
