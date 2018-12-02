# frozen_string_literal: true

require 'uri'
require './application_record'
require 'mail'

# Documentation about class User
class Order < ApplicationRecord
  attr_reader :state

  def valid_cost
    pm = ProvidedMaterial.find_by(name: self.provider, material: self.material)
    return false unless cost.eql?(pm.ppu * self.qty)

    true
  end

  def deduct_budget(value, bmanager)
    proj = Project.find_by(id: id = projid)
    return false unless bmanager.can_deduct_more(value, id) &&
                        [nil].include?(state) && valid_cost

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
