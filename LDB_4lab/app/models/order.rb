# frozen_string_literal: true

require 'uri'
require './application_record'
require 'mail'

# Documentation about class User
class Order < ApplicationRecord
  # after create - deduct project's budget
  def deduct_budget(value)
    pid = projid
    proj = Project.find_by(id: pid)
    return false unless BudgetManager.new.can_deduct_more(value, pid)

    proj.budget -= value
    proj.save
    true
  end

  def order_received
    destroy
  end

  # If the order is cancelled
  def restore_budget
    bm = BudgetManager.new
    pid = projid
    oldb = bm.budgets_getter(pid)
    bm.budgets_setter(pid, oldb + cost)
    order_received
  end
end
