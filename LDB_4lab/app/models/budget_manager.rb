# frozen_string_literal: true

require 'date'
require 'etc'
require_relative 'project'
require './application_record'
require 'yaml'

# Manages financial information about projects
class BudgetManager
  # Initialize with a @state variable?

  def check_negative # Is not possible anymore?
    arr = []
    lofids = Project.all.ids
    lofids.each do |ids|
      proj = Project.find_by(id: ids)
      arr.push(proj.name) if proj.budget < 0
    end

    arr
  end

  def can_deduct_more(value, projid)
    return true if (Project.find_by(id: projid).budget - value) >= 0
    false
  end

  def budgets_getter(projid)
    Project.find_by(id: projid).budget
  end

  def budgets_setter(projid, value)
    proj = Project.find_by(id: projid)
    proj.budget = value
    proj.save
  end
end
