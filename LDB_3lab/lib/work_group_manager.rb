require_relative 'work_group'
require 'yaml'

class WorkGroupManager
  def initialize
    @groups = YAML.load_file('workgroups.yml')
  end

  def get_user_groups(user)
  end

  def save_group(group)
    hash = group.to_hash
    File.open('workgroups.yml', 'a') { |fl| fl.write hash.to_yaml.sub('---', '') }
    true
  end

  def delete_group(group)
    @groups.delete(group.data_getter('id'))
    File.open('workgroups.yml', 'w') { |fl| fl.write @groups.to_yaml.sub('---', '') }
    true
  end
end
