# frozen_string_literal: true

require './application_record'
require 'etc'

# rubocop comment?
class Search
  def initialize
    @instancevariable = true
  end

  def parm_instancevariable(val = @instancevariable)
    @instancevariable = val
  end

  def gather_data(modl, value) # Could be a 2x mock here (called/not)
    modlclass = modl.classify.constantize
    cols = modlclass.column_names
    cols.each do |cl|
      return [modl + ' has: ',
              value] if modlclass.where("#{cl} LIKE ?", value).first
    end
    ''
  end

  def search_by_criteria(criteria, value)
    result = []
    return result if [nil].include?(value)
    criteria.each do |modl|
      result.push(gather_data(modl, value))
    end
    result
  end
end
