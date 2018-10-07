require 'securerandom' # random hash kuriantis metodas yra
require_relative 'projektas'
require_relative 'darbo_grupe'
require 'uri'

# Documentation about class vartotojas
class Vartotojas
  attr_reader :user_info
  attr_reader :projects

  def initialize(name: '', last_name: '', email: '', phone_number: '')
    @user_info = []
    @user_info.push(name)
    @user_info.push(last_name)
    @user_info.push(email)
    @user_info.push(phone_number)
    @user_info.push(0) # user_id

    @projects = {}
    @qualification_certificates = [] # Array.new
  end

  def name_lastname_getter
    [@user_info[0], @user_info[1]]
  end

  def unique_id_setter(id = SecureRandom.hex)
    @user_info[4] = id
  end

  def unique_id_getter
    @user_info[4]
  end

  def equals(other_user)
    return true if @user_info == other_user.user_info

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

  # def change_project_status(project, status)
  # key = project.to_s.to_sym
  # @projects[project] = status
  # end

  def create_project(project_name, file_name)
    # object =
    sysprojlog = SystemProjectLogger.new([project_name, @user_info[4],
                                          file_name])
    sysprojlog.log_project_creation
    Projektas.new(project_name: project_name, meta_filename: file_name)
    # return object
  end

  def delete_project(proj)
    sysprojlog = SystemProjectLogger.new([project_name, @user_info[4],
                                          file_name])
    sysprojlog.log_project_delete
    proj.set_deleted_status
  end

  def create_work_group(work_group_name)
    sysgrlog = SystemGroupLogger.new([work_group_name, @user_info[4]])
    sysgrlog.log_work_group_creation
    DarboGrupe.new(work_group_name: work_group_name)
  end

  def delete_work_group(group)
    group.set_deleted_status(@user_info[4])
  end

  def upload_certificate(file)
    regex = Regexp.new('([a-zA-Z0-9_.\-])+(.doc|.docx|.pdf)$')
    sysusrlogger = SystemUserLogger.new([@user_info[0], @user_info[1], '', '',
                                         file])
    return sysusrlogger.log_certificate_upload if regex.match?(file)

    false
  end

  def resend_password_link
    # should later work based on Rails gem 'EmailVeracity'
    if @user_info[2] =~ /\A[^@\s]{5,}+@([^@.\s]{4,}+\.)+[^@.\s]{2,}+\z/
      sysusrlog = SystemUserLogger.new([@user_info[0], @user_info[1],
                                        @user_info[4], 0])
      sysusrlog.log_password_request
      true
    else
      false
    end
  end
end
