require_relative 'user'
class WorkGroup
  def initialize(id, project_id, group_name, tasks)
    @data = {id: id, project_id: project_id, group_name: group_name,  tasks: tasks}
    @members = []
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
        'project_id' => data_getter('project_id'),
        'group_name' => data_getter('group_name'),
        @members => members_getter,
        'tasks' => data_getter('tasks')
      }
    }
    return hash
  end

  def add_group_member(user)
    address = user.data_getter('email');
    #members = members_getter
    return false if @members.include?(address)

    @members.push(address)
    true
  end

  def remove_group_member(user)
    address = user.data_getter('email');
    #members = members_getter
    return false unless @members.include?(address)

    @members.delete(address)
    @members.include?(user.data_getter('email'))
    true
  end

  def members_getter
    @members
  end

  def add_group_task(text)
    tasks = data_getter('tasks')
    tasks.push(text.to_s)
    data_setter('tasks', tasks);
    true
  end

  def delete_group_task(index)
    tasks = data_getter('tasks')
    return false if (index < 0 || index >= tasks.length)

    tasks.delete_at(index)
    data_setter('tasks', tasks)
    true
  end
end
