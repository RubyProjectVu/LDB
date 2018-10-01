require 'date'
require 'etc'

# rubocop comment?
class Projektas
  attr_reader :name_and_meta
  # attr_reader :meta_filename
  # attr_reader :project_name
  attr_reader :project_manager
  attr_reader :project_status
  attr_reader :project_deleted
  attr_reader :members
  attr_reader :subscriber_members

  def initialize(
    project_name: 'Default_project_' + Date.today.to_s,
    meta_filename: 'metadata.txt'
  )
    @name_and_meta = [project_name, meta_filename]
    # @project_name = project_name
    # @meta_filename = meta_filename
    @project_manager = Etc.getlogin
    File.new(@name_and_meta[1], 'w').close # File.new(meta_filename, 'w')
    # metafile.close
    @members = []
    @subscriber_members = {}
    @project_deleted = false
  end

  def check_metadata
    # outcome = File.file?(@name_and_meta[1]) # File.file?(@meta_filename)
    if File.file?(@name_and_meta[1]) # outcome
      # File.foreach(@meta_filename, 'r') do |line|
      File.foreach(@name_and_meta[1], 'r') do |line|
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
    # begin
    # var = File.delete(file_name) # delete gali mest exception
    if File.delete(file_name) == 1 # var == 1
      file = File.new(file_name, 'w') # TEST PURPOSES
      file.puts('a') # TEST PURPOSES
      true
    end
  rescue StandardError
    false
    # end
  end

  def parm_manager(name = '')
    @project_manager = name if !name.to_s.empty?
      # else
      @project_manager
    # end
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

  def add_subscriber(name, email)
    !@subscriber_members.key?(name) ? @subscriber_members[name] = email : false
    # else
    # end
  end

  def remove_subscriber(name)
    @subscriber_members.key?(name) ? @subscriber_members.delete(name) : false
    # else
    # end
  end

  def notify_subscribers(names_sent = [])
    # names_sent = []
    @subscriber_members.each do |name, email|
      str = /\A[^@\s]{5,}+@([^@.\s]{4,}+\.)+[^@.\s]{2,}+\z/
      names_sent.push(name) if email =~ str # /\A[^@\s]{5,}+@([^@.\s]{4,}+\.)+[^@.\s]{2,}+\z/
    # should ideally send template mesasges
    # end
    end
    names_sent
  end

  def project_status_array
    var = ['Proposed', 'Suspended', 'Postponed', 'Cancelled', 'In progress']
    # var.push('Proposed').push('Suspended').push('Postponed')
    # var.push('Cancelled').push('In progress')
    # var
  end

  def project_status__message
    var = 'Proposed, Suspended, Postponed, Cancelled, In progress'
    # postfix = var.join(', ')
    prefix = 'Please set status as one of: '
    prefix + var # postfix
  end

  def parm_project_name(name = '')
    # @project_name = name if !name.to_s.empty?
    @name_and_meta[0] = name if !name.to_s.empty?
      # else
      @name_and_meta[0] # @project_name
    # end
  end

  def add_member(vart)
    return false if vart.nil? || @members.include?(vart.user_id)

    # return false if @members.include?(vart.user_id)
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
    # return false if @project_deleted == true
    # @project_deleted = true
    @project_deleted == true ? false : @project_deleted = true
  end
end
