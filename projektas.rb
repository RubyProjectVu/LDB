require 'date'
require 'etc'

# rubocop comment?
class Projektas
  attr_reader :meta_filename
  attr_reader :project_name
  attr_reader :project_manager
  attr_reader :project_status
  attr_reader :project_deleted
  attr_reader :members

  def initialize(project_name: 'Default_project_' + Date.today.to_s, meta_filename: 'metadata.txt')
    @project_name = project_name
    @meta_filename = meta_filename
    @project_manager = Etc.getlogin
    metafile = File.new(meta_filename, 'w')
    metafile.close
    @members = []
    @project_deleted = false
  end

  def check_metadata
    outcome = File.file?(@meta_filename)
    if outcome
      File.foreach(@meta_filename, 'r') do |line|
        print "Check if #{line} exists"
      end
      true
    end
  end

  def modify_file(file_name, to_create_file)
    if to_create_file
      create_file(file_name)
    else
      delete_file(file_name)
    end
  end

  def create_file(file_name)
    File.new(file_name, 'w')
    true
  end

  def delete_file(file_name)
    begin
      var = File.delete(file_name) # delete gali mest exception
      if var == 1
        file = File.new(file_name, 'w') # TEST PURPOSES
        file.puts('a') # TEST PURPOSES
        return true
      end
    rescue StandardError
      return false
    end
  end

  def parm_manager(name = '')
    if !name.to_s.empty?
      @project_manager = name
    else
      @project_manager
    end
  end

  def parm_project_status(status = '')
    if !status.to_s.empty?
      option_array = project_status_array
      if option_array.include? status
        @project_status = status
      else
        project_status__message
      end
    else
      @project_status
    end
  end

  def project_status_array
    var = []
    var.push('Proposed').push('Suspended').push('Postponed')
    var.push('Cancelled').push('In progress')
    var
  end

  def project_status__message
    postfix = project_status_array.join(', ')
    prefix = 'Please set status as one of: '
    prefix + postfix
  end

  def parm_project_name(name = '')
    if !name.to_s.empty?
      @project_name = name
    else
      @project_name
    end
  end

  def add_member(vart)
    return false if vart.nil?
    return false if @members.include?(vart.user_id)

    @members.push(vart.user_id)
    true
  end

  def remove_member(vart)
    return false if vart.nil?
    return false unless @members.include?(vart.user_id)

    @members.delete(vart.user_id)
    true
  end

  def set_deleted_status
    return false if @project_deleted == true

    @project_deleted = true
  end
end
