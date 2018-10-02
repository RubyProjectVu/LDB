require 'securerandom' # random hash kuriantis metodas yra
require_relative 'projektas'
require_relative 'darbo_grupe'
require 'uri'

# Documentation
class Vartotojas
  attr_reader :name
  attr_reader :last_name
  attr_reader :email
  attr_reader :gender
  attr_reader :user_id
  attr_reader :phone_number
  attr_reader :projects

  def initialize(name: '', last_name: '', email: '', phone_number: '')
    @name = name
    @last_name = last_name
    @email = email
    @phone_number = phone_number
    @projects = {}
    @qualification_certificates = [] # Array.new
  end

  def unique_id_setter(id = SecureRandom.hex)
    @user_id = id
  end

  def unique_id_getter
    @user_id
  end

  def equals(other_user)
    if @name == other_user.name &&
       @last_name == other_user.last_name &&
       @email == other_user.email &&
       @user_id == other_user.user_id
      return true
    end

    false
  end

  def prepare_deletion
    active_projects = gather_active_projects
    return true if active_projects.none?

    # should ideally mark userid as deleted on another entity {System}
    # return true
    # else
    # should ideally contact project managers
    false
    # end
  end

  def gather_active_projects
    active_projects = []
    @projects.each do |name, status|
      active_projects.push(name) if status.eql? 'In progress'
    end
    active_projects
  end

  def add_project(project, status)
    # should ideally determine if project manager approves first
    # key = project.to_s.to_sym
    @projects[project] = status
  end

  def change_project_status(project, status)
    # key = project.to_s.to_sym
    @projects[project] = status
  end

  def create_project(project_name, file_name)
    # object =
    Projektas.new(project_name: project_name, meta_filename: file_name)
    # return object
  end

  def delete_project(proj)
    if proj.nil?
      # puts 'Invalid object reference'
      return false
    end

    proj.set_deleted_status
  end

  def create_work_group(work_group_name)
    object = DarboGrupe.new(work_group_name: work_group_name)
    return object
  end

  def delete_work_group(group)
    if group.nil?
      return false
    end

    return group.set_deleted_status
  end

  def upload_certificate(file)
    regex = Regexp.new('([a-zA-Z0-9_.\-])+(.doc|.docx|.pdf)$')
    regex.match?(file)
  end

  def resend_password_link
    # should later work based on Rails gem 'EmailVeracity'
    if @email =~ /\A[^@\s]{5,}+@([^@.\s]{4,}+\.)+[^@.\s]{2,}+\z/
      true
    else
      false
    end
  end
end
