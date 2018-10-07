require 'securerandom' # random hash kuriantis metodas yra
require_relative 'project'
require_relative 'work_group'
require 'uri'

<<<<<<< HEAD:______old_project_files/vartotojas.rb
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
=======
# Documentation about class User
class User
  attr_reader :info
  # attr_reader :name
  # attr_reader :last_name
  # attr_reader :email
  # attr_reader :gender -> To address book
  attr_reader :user_id
  # attr_reader :phone_number -> To address book
  attr_reader :projects

  def initialize(name: '', last_name: '', email: '')
    @info = []
    @info[0] = name
    @info[1] = last_name
    @info[2] = email
    # @name = name
    # @last_name = last_name
    # @email = email
    # @phone_number = phone_number
    @projects = {}
    # @qualification_certificates = [] Nebuvo naudotas? Galesim det i DB 'file'
    @user_id = ''
>>>>>>> paulius:______old_project_files/user.rb
  end

  def user_input_validation
    if !info[0].match(/[a-zA-Z][a-z]+/) ||
       !info[1].match(/[a-zA-Z][a-z]+/) ||
       !info[2].match(/[a-zA-Z0-9]+[@][a-zA-Z0-9]+[.][a-zA-Z]+/)
      return false
    end

    true
  end

  def name_lastname_getter
<<<<<<< HEAD:______old_project_files/vartotojas.rb
    [@user_info[0], @user_info[1]]
=======
    [@info[0], @info[1]]
  end

  def email_getter
    @info[2]
>>>>>>> paulius:______old_project_files/user.rb
  end

  def unique_id_setter(id = SecureRandom.hex)
    @user_info[4] = id
  end

  def unique_id_getter
    @user_info[4]
  end

  def equals(other_user)
<<<<<<< HEAD:______old_project_files/vartotojas.rb
    return true if @user_info == other_user.user_info
=======
    info = other_user.name_lastname_getter
    if @info[0] == info[0] &&
       @info[1] == info[1] &&
       @info[2] == other_user.email_getter &&
       @user_id == other_user.unique_id_getter
      return true
    end
>>>>>>> paulius:______old_project_files/user.rb

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
    Project.new(project_name: project_name, meta_filename: file_name)
    # return object
  end

<<<<<<< HEAD:______old_project_files/vartotojas.rb
  def delete_project(proj)
    sysprojlog = SystemProjectLogger.new([project_name, @user_info[4],
                                          file_name])
    sysprojlog.log_project_delete
    proj.set_deleted_status
  end
=======
  # def delete_project(proj)
  #  if proj.nil?
  # puts 'Invalid object reference'
  #    return false
  #  end
  #
  #  proj.set_deleted_status
  # end
>>>>>>> paulius:______old_project_files/user.rb

  def create_work_group(work_group_name)
    sysgrlog = SystemGroupLogger.new([work_group_name, @user_info[4]])
    sysgrlog.log_work_group_creation
    WorkGroup.new(work_group_name: work_group_name)
  end

<<<<<<< HEAD:______old_project_files/vartotojas.rb
  def delete_work_group(group)
    group.set_deleted_status(@user_info[4])
  end

  def upload_certificate(file)
    regex = Regexp.new('([a-zA-Z0-9_.\-])+(.doc|.docx|.pdf)$')
    sysusrlogger = SystemUserLogger.new([@user_info[0], @user_info[1], '', '',
                                         file])
=======
  # def delete_work_group(group)
  #  if group.nil?
  # puts 'Invalid object reference'
  #    return false
  #  end
  #
  #  group.set_deleted_status(@user_id)
  # end

  def upload_certificate(file)
    regex = Regexp.new('([a-zA-Z0-9_.\-])+(.doc|.docx|.pdf)$')
    sysusrlogger = SystemUserLogger.new([@info[0], @info[1], '', '', file])
>>>>>>> paulius:______old_project_files/user.rb
    return sysusrlogger.log_certificate_upload if regex.match?(file)

    false
  end

  def resend_password_link
    # should later work based on Rails gem 'EmailVeracity'
<<<<<<< HEAD:______old_project_files/vartotojas.rb
    if @user_info[2] =~ /\A[^@\s]{5,}+@([^@.\s]{4,}+\.)+[^@.\s]{2,}+\z/
      sysusrlog = SystemUserLogger.new([@user_info[0], @user_info[1],
                                        @user_info[4], 0])
=======
    if info[2] =~ /\A[^@\s]{5,}+@([^@.\s]{4,}+\.)+[^@.\s]{2,}+\z/
      sysusrlog = SystemUserLogger.new([@info[0], @info[1], @user_id, @info[2]])
>>>>>>> paulius:______old_project_files/user.rb
      sysusrlog.log_password_request
      true
    else
      false
    end
  end
end
