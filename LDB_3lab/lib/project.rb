# frozen_string_literal: true

require 'date'
require 'etc'

# rubocop comment?
class Project
  def initialize(
    project_name: 'Default_project_' + Date.today.to_s,
    meta_filename: 'metadata.txt'
  )
    @name_meta_man = { name: project_name, meta: meta_filename,
                       manager: Etc.getlogin }
    File.new meta_filename, 'w'
    @members = []
    @subscriber_members = {}
    @project_status = 'Proposed'
  end

  def check_metadata
    var = @name_meta_man.fetch(:meta)
    return false unless File.file?(var)

    # should check if all components are set and present in yml
    true
  end

  def meta_getter
    @name_meta_man.fetch(:meta)
  end

  def parm_manager(name = '')
    @name_meta_man[:manager] = name unless name.empty?
    @name_meta_man.fetch(:manager)
  end

  def parm_project_status(status = '')
    if !status.empty?
      return @project_status = status if ['Proposed', 'Suspended', 'Postponed',
                                          'Cancelled',
                                          'In progress'].include? status

      false
    else
      @project_status
    end
  end

  def add_subscriber(name, email)
    !@subscriber_members.key?(name) ? @subscriber_members[name] = email : false
  end

  def remove_subscriber(name)
    @subscriber_members.key?(name) ? @subscriber_members.delete(name) : false
  end

  def notify_subscribers(names_sent = [])
    @subscriber_members.each_key do |name|
      names_sent.push(name)
      # should ideally send template mesasges
    end
    names_sent
  end

  def parm_project_name(name = '')
    @name_meta_man[:name] = name unless name.empty?
    @name_meta_man.fetch(:name)
  end

  def add_member(vart)
    id = vart.data_getter('email')
    return false if @members.include?(id)

    @members.push(id)
    true
  end

  def remove_member(vart)
    id = vart.data_getter('email')
    return false unless @members.include?(id)

    @members.delete(id)
    true
  end

  def members_getter
    @members
  end

  def set_deleted_status
    if @project_status.eql?('Deleted')
      false
    else
      @project_status = 'Deleted'
      true
    end
  end
end
