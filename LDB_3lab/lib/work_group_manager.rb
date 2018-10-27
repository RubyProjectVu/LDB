require_relative 'work_group'
require 'yaml'

class WorkGroupManager
  def initialize
    @groups = YAML.load_file('workgroups.yml')
  end

  def get_user_groups(user)
  end

  def save_group(group)
    return false if @groups.key?(group.data_getter('id'))

    hash = group.to_hash
    File.open('workgroups.yml', 'a') { |fl| fl.write hash.to_yaml.sub('---', '') }
    true
  end

  def delete_group(group)
    return false unless @groups.key?(group.data_getter('id'))

    hash = group.to_hash
    File.open('workgroups.yml', 'a') { |fl| fl.write hash.to_yaml.sub('---', '') }
    true
  end
end
