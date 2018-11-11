# frozen_string_literal: true

require 'date'
require 'etc'
require_relative 'project'
require './application_record'
require 'yaml'

# Manages financial information about projects
class BudgetManager
  # Initialize with a @state variable?

  def check_negative
    arr = []
    lofids = Project.all.ids
    lofids.each do |t|
      proj = Project.find_by(id: t)
      arr.push(proj.name) if proj.budget < 0
    end

    arr
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
