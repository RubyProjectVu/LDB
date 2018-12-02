# frozen_string_literal: true

require './application_record'
require 'project_manager'

# Creates graphs
class Graph
  def initialize
    @calc_average = true
  end

  def create_projects_and_members_graph(prj_mngr)
    max_val = sum = 0
    (hsh = prj_mngr.gen_projects_and_members_hash).each_value do |val|
      max_val = val if max_val < val
      sum += val if @calc_average
    end
    [max_val, sum, hsh]
  end
end
