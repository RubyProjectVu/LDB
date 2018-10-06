require 'date'
require 'etc'

# Documentation for darbo grupe
class DarboGrupe
  attr_reader :work_group_name
  attr_reader :work_group_manager
  attr_reader :work_group_deleted
  attr_reader :members

  def initialize(work_group_name: 'Default_work_group_' + Date.today.to_s)
    @work_group_name = work_group_name
    @work_group_manager = Etc.getlogin
    @members = []
    @work_group_deleted = false
  end

  def parm_manager(name = '')
    # should ideally receive input from user
    @work_group_manager = name unless name.to_s.empty?
    @work_group_manager
  end

  def parm_work_group_name(name = '')
    @work_group_name = name unless name.to_s.empty?
    @work_group_name
  end

  def add_member(vart)
    # id = ''
    # return false if vart.nil? || @members.include?(id = vart.user_id)
    return false if @members.include?(id = vart.user_id)

    # return false if @members.include?(vart.user_id)
    @members.push(id)
    true
  end

  def remove_member(vart)
    # return false if vart.nil?
    return false unless @members.include?(id = vart.user_id)

    @members.delete(id)
    true
  end

  def set_deleted_status(user_id)
    if @work_group_deleted == true
      # puts "Work_group is already deleted"
      false
    else
      sysgrlog = SystemGroupLogger.new([@work_group_name, user_id])
      sysgrlog.log_work_group_deletion
      @work_group_deleted = true
    end
  end
end
