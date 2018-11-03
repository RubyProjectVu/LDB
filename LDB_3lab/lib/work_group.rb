# frozen_string_literal: true

require_relative 'user'

# Defines a workgroup
class WorkGroup
  def initialize(id, project_id, group_name)
    @data = { id: id, project_id: project_id,
              group_name: group_name }
    @members = []
    @tasks = []
  end

  def data_getter(key)
    @data.fetch(key.to_sym)
  end

  def data_setter(key, val)
    @data[key.to_sym] = val
  end

  def to_hash
    {
      data_getter('id') => {
        'project_id' => data_getter('project_id'),
        'group_name' => data_getter('group_name'),
        'members' => members_getter,
        'tasks' => tasks_getter
      }
    }
  end

  def add_group_member(user)
    address = user.data_getter('email')
    # members = members_getter
    return false if @members.include?(address)

    @members.push(address)
    true
  end

  def remove_group_member(user)
    address = user.data_getter('email')
    # members = members_getter
    return false unless @members.include?(address)

    @members.delete(address)
    true
  end

  def add_group_task(task)
    @tasks.push(task)
    true
  end

  def remove_group_task(task)
    @tasks.delete(task)
    true
  end

  def members_getter
    @members
  end

  def tasks_getter
    @tasks
  end
end
