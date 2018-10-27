require_relative 'work_group_task'

class WorkGroup
  def initialize(group_name, members, tasks)
    @data = {name: group_name, members: members, tasks: tasks}
  end

  def data_getter(key)
    @data.fetch(key.to_sym)
  end

  def data_setter(key, val)
    @data[key.to_sym] = val
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
