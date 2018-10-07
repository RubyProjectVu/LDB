require 'date'
require 'etc'

# rubocop comment?
class Project
  attr_reader :name_meta_man
  # attr_reader :project_manager
  attr_reader :project_status
  # attr_reader :project_deleted
  attr_reader :members
  attr_reader :subscriber_members

  def initialize(
    project_name: 'Default_project_' + Date.today.to_s,
    meta_filename: 'metadata.txt'
  )
    @name_meta_man = [project_name, meta_filename, Etc.getlogin]
    # @project_manager = Etc.getlogin
    File.new(@name_meta_man[1], 'w').close # File.new(meta_filename, 'w')
    @members = []
    @subscriber_members = {}
    @project_status = 'Proposed'
  end

  def check_metadata
    # outcome = File.file?(@name_meta_man[1]) # File.file?(@meta_filename)
    var = @name_meta_man[1]
    false unless File.file?(var)
    # File.foreach(@meta_filename, 'r') do |line|
    File.foreach(var, 'r') do
      # print "Check if #{line} exists"
    end
    true
    # end
  end

  # def modify_file(file_name, to_create_file)
  #  if to_create_file
  #    create_file(file_name)
  #  else
  #    delete_file(file_name)
  #  end
  # end

  # def create_file(file_name)
  #  File.new(file_name, 'w')
  #  true
  # end

  # def delete_file(file_name)
  # begin
  # var = File.delete(file_name) # delete gali mest exception
  #  if File.delete(file_name) == 1 # var == 1
  #    file = File.new(file_name, 'w') # TEST PURPOSES
  #    file.puts('a') # TEST PURPOSES
  #    true
  #  end
  # rescue StandardError
  #  false
  # end
  # end

  def parm_manager(name = '')
    @name_meta_man[2] = name unless name.to_s.empty?
    # else
    @name_meta_man[2]
    # end
  end

  def parm_project_status(status = '')
    if !status.to_s.empty?
      @project_status = status if ['Proposed', 'Suspended', 'Postponed',
                                   'Cancelled',
                                   'In progress', 'Deleted'].include? status
      'Please set status as one of: Proposed, Suspended, Postponed, '\
       'Cancelled, In progress'
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
      names_sent.push(name) if email =~ str
      # should ideally send template mesasges
      # end
    end
    names_sent
  end

  def parm_project_name(name = '')
    # @project_name = name if !name.to_s.empty?
    @name_meta_man[0] = name unless name.to_s.empty?
    # else
    @name_meta_man[0] # @project_name
    # end
  end

  def add_member(vart)
    # return false if vart.nil? || @members.include?(vart.user_id)
    id = vart.user_id
    return false if @members.include?(id)

    # return false if @members.include?(vart.user_id)
    @members.push(id)
    true
  end

  def remove_member(vart)
    id = vart.user_id
    # return false if vart.nil?
    return false unless @members.include?(id)

    @members.delete(id)
    true
  end

  def set_deleted_status
    # return false if @project_deleted == true
    # @project_deleted = true
    if @project_status == 'Deleted'
      false
    else
      @project_status = 'Deleted'
      true
    end
  end
end
