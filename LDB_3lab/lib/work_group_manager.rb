require_relative 'work_group'
require 'yaml'

class WorkGroupManager
  def initialize
    @groups = YAML.load_file('workgroups.yml')
  end

  def get_user_groups(user)
  end

  def create_group(name)
  end

  def delete_group(group)
  end
end
