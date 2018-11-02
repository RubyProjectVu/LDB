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
    arr = []
    @budgets.each_key do |key|
      if @budgets[key].fetch('budget') < 0
        arr.push(key)
      end
    end
    arr
  end

  def budgets_getter(projid)
    @budgets[projid].fetch('budget')
  end

  def budgets_setter(projid, value)
    hash = { projid => { 'budget' => value } }
    File.open('budgets.yml', 'a') { |fl| fl.write hash.to_yaml.sub('---', '') }
  end
end
