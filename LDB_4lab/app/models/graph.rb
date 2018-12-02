require './application_record'
require 'project_manager'

class Graph
  def initialize
  end

  def create_projects_and_members_graph(prj_mngr)
    info = [0, 0]
    (hsh = prj_mngr.gen_projects_and_members_hash).each_value { |val|
      info[0] = val if info[0] < val
      info[1] += val
    }
    [info[0], info[1], hsh]
  end
end
