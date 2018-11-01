# frozen_string_literal: true
require_relative 'work_group'
require 'yaml'

# Saves and writes work group related data
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
    File.open('workgroups.yml', 'a') do |fl|
      fl.write hash.to_yaml.sub('---', '')
    end
    load_yaml
    true
  end

  def delete_group(group)
    id = group.data_getter('id')
    return false unless @groups != false &&
                        @groups.key?(id)

    @groups.delete(id)
    File.open('workgroups.yml', 'w') do |fl|
      fl.write @groups.to_yaml.sub('---', '').sub('{}', '')
    end
    true
  end
end
