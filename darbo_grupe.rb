require 'date'
require 'etc'

# Documentation
class Darbo_grupe
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
  
  def parm_manager(name = "")
    # should ideally receive input from user
    unless name.to_s.empty?
      @work_group_manager = name
    end
    return @work_group_manager
  end

  def parm_work_group_name(name = "")
    unless name.to_s.empty?
      @work_group_name = name
    else
      return @work_group_name
    end
  end

  def add_member(vart)
    if vart == nil
      # puts "Invalid Vartotojas"
      return false
    end

    if @members.include?(vart.user_id)
      # puts "This member is already assigned to this work_group"
      return false
    end

    @members.push(vart.user_id)
    return true
  end

  def remove_member(vart)
    if vart == nil
      # puts "Invalid Vartotojas"
      return false
    end
    if !@members.include?(vart.user_id)
      # puts "This member is not assigned to this work_group"
      return false
    end
    @members.delete(vart.user_id)
    return true
  end

  def set_deleted_status
    if @work_group_deleted == true
      # puts "Work_group is already deleted"
      return false
    end
    @work_group_deleted = true
    return true
  end
end