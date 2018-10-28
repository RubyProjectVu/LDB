require_relative 'work_group'
require 'yaml'

class WorkGroupManager
  def initialize
    load_yaml
  end

  def load_yaml
    @groups = YAML.load_file('workgroups.yml')
  end

  def save_group(group)
    delete_group(group)

    hash = group.to_hash
    File.open('projects.yml', 'a') { |fl| fl.write hash.to_yaml.sub('---', '') }

    load_yaml
    true
  end

  def delete_group(group)
    return false unless @groups.key?(group.data_getter('id'))

    @groups.delete(group.data_getter('id'))
    File.open('workgroups.yml', 'w') { |fl| fl.write @groups.to_yaml.sub('---', '') }
    true
  end
end
