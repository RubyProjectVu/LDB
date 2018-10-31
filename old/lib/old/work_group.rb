# frozen_string_literal: true

require 'date'
require 'etc'

# Documentation for darbo grupe
class WorkGroup
  def initialize(work_group_name: 'Default_work_group_' + Date.today.to_s)
    @work_group_name = work_group_name
    @work_group_manager = Etc.getlogin
    @members = []
    @work_group_deleted = false
  end

  def deleted?
    @work_group_deleted
  end

  def parm_manager(name = '')
    @work_group_manager = name unless name.empty?
    @work_group_manager
  end

  def parm_work_group_name(name = '')
    @work_group_name = name unless name.empty?
    @work_group_name
  end

  def add_member(vart)
    return false if @members.include?(id = vart.data_getter('email'))

    @members.push(id)
    true
  end

  def remove_member(vart)
    return false unless @members.include?(id = vart.data_getter('email'))

    @members.delete(id)
    true
  end

  def deleted_status_setter
    if @work_group_deleted
      false
    else
      @work_group_deleted = true
    end
  end
end
