# frozen_string_literal: true

# require_relative 'work_group'
require './application_record'
require 'yaml'

# Saves and writes work group related data
class WorkGroupManager
  def save_group(name)
    WorkGroup.create(name: name)
    true
  end

  def delete_group(group)
    wg = WorkGroup.find_by(id: group)
    wg.destroy
    true
  end

  def list_groups
    arr = []
    lofids = WorkGroup.all.ids
    lofids.each do |t|
      arr.push(t.to_s + ':' + (WorkGroup.find_by id: t).name)
    end

    arr
  end
end
