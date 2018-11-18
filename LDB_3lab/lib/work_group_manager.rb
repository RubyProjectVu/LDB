# frozen_string_literal: true

require_relative 'work_group'
require 'yaml'

# Saves and writes work group related data
class WorkGroupManager
  def initialize
    @groups = YAML.load_file('workgroups.yml')
  end

  def save_group(group)
    gr = gro = group
    delete_group(gro.data_getter('id'))
    hash = gr.to_hash
    File.open('workgroups.yml', 'a') do |fl|
      fl.write hash.to_yaml.sub('---', '')
    end
  end

  def delete_group(id)
    @groups.delete(id)
    File.open('workgroups.yml', 'w') do |fl|
      fl.write @groups.to_yaml.sub('---', '').sub('{}', '')
    end
    true
  end

  def load_group(id)
    return false unless @groups.key?(id)
    gr = gro = @groups.fetch(id)

    l_bdg(l_tsk(l_mem(WorkGroup.new(id, gro.fetch('project_id'),
                                    gr.fetch('group_name')), id), id), id)
  end

  def l_mem(obj, id)
    gro = @groups.fetch(id)
    obj.members_getter(gro.fetch('members'))

    # obj = load_tasks(obj, id)
    obj # load_tasks(obj, id)
  end

  def l_tsk(obje, id)
    gro = @groups.fetch(id)
    obje.tasks_getter(gro.fetch('tasks'))

    # obje = load_budget(obje, id)
    obje
  end

  def l_bdg(objc, id)
    gr = @groups.fetch(id)
    objc.budget_construct_only(gr.fetch('budget'))

    objc
  end

  def list_groups
    arr = []
    @groups.each_key do |key|
      arr.push(key + ':' + @groups.fetch(key).fetch('group_name'))
    end
    arr
  end
end