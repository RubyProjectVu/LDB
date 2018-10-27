
class WorkGroup
  def initialize(id, group_name, members, tasks)
    @data = [id, group_name, members, tasks]
  end

  def id
    @data[0]
  end

  def name
    @data[1]
  end

  def members
    @data[2]
  end

  def tasks
    @data[3]
  end
end
