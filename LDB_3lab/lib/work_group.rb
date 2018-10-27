require_relative 'work_group_task'

class WorkGroup
  def initialize(id, group_name, members, tasks)
    @data = {id: id, name: group_name, members: members, tasks: tasks}
  end

  def data_getter(key)
    @data.fetch(key.to_sym)
  end

  def data_setter(key, val)
    @data[key.to_sym] = val
  end

  def to_hash
    hash = {
      data_getter('id') => {
        'group_name' => data_getter('group_name'),
        'members' => data_getter('members'),
        'tasks' => data_getter('tasks')
      }
    }
    return hash
  end

  def add_group_member(user)
    @members = data_getter('members')
    @members.push(user)
    data_setter('members', @members);
  end

  def remove_group_member(user)
  end

  def add_group_task(task)
  end

  def delete_group_task(task)
  end
end
