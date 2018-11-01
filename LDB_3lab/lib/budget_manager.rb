# frozen_string_literal: true

require 'date'
require 'etc'
require_relative 'project'
require 'yaml'

# Manages financial information about projects
class BudgetManager
  def initialize
    @budgets = YAML.load_file('budgets.yml')
  end

  def check_negative
    
  end

  def all_budgets
    
  end
end
