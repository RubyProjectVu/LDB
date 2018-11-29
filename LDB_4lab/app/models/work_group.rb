# frozen_string_literal: true

require './application_record'
require_relative 'work_group_member'
require_relative 'work_group_task'

# Defines a workgroup
class WorkGroup < ApplicationRecord
  has_many :work_group_members
  has_many :work_group_tasks

  def members_getter
    arr = []
    list = WorkGroupMember.where(wgid: id)
    list.each do |t|
      arr.push(t.member)
    end
    arr
  end

  def data_setter(key, val)
    case key
    when 'name'
      wg = WorkGroup.find_by(id: id)
      wg.name = val
    end
    wg.save
  end

  def project_budget_setter(amount)
    projid = self.projid
    budget = self.budget
    old = BudgetManager.new.budgets_getter(projid)
    BudgetManager.new.budgets_setter(projid, old + (budget - amount))
  end

  def add_group_member(mail)
    return false if WorkGroupMember.find_by(wgid: id, member: mail)

    WorkGroupMember.create(wgid: id, member: mail)
    true
  end

  def remove_group_member(mail)
    wgm = WorkGroupMember.find_by(wgid: id, member: mail)
    return false if [nil].include?(wgm)

    wgm.destroy
    true
  end

  def add_group_task(task)
    WorkGroupTask.create(wgid: id, task: task)
    true
  end

  def remove_group_task(task)
    wgt = WorkGroupTask.find_by(wgid: id, task: task)
    return false if [nil].include?(wgt)

    wgt.destroy
    true
  end

  def tasks_getter
    arr = []
    list = WorkGroupTask.where(wgid: id)
    list.each do |t|
      arr.push(t.task)
    end
    arr
  end
end
