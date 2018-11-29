# frozen_string_literal: true

require 'uri'
require './application_record'
require 'mail'

# Documentation about class User
class Order < ApplicationRecord
  # after create - deduct project's budget
  def deduct_budget(value)
    pid = self.projid
    proj = Project.find_by(id: pid)
    if BudgetManager.new.can_deduct_more(value, pid)
      proj.budget -= value
      proj.save
    else
      return false
    end
    true
  end

  def order_received
    self.destroy
  end

  # If the order is cancelled
  def restore_budget
    bm = BudgetManager.new
    pid = self.projid
    oldb = bm.budgets_getter(pid)
    bm.budgets_setter(pid, oldb + self.cost)
    order_received
  end
end
