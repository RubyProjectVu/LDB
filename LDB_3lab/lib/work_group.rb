require_relative 'work_group_task'

class WorkGroup
  def initialize(group_name, members, tasks)
    @data = [group_name, members, tasks]
  end

  def add_group_member(user)
  end

  def remove_group_member(user)
  end

  def add_group_task(task)
  end

  def delete_group_task(task)
  end
end
