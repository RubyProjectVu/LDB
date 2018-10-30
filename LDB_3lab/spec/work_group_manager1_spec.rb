# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/work_group_manager'
require_relative '../lib/work_group'
require 'date'

describe WorkGroupManager do
  let(:wgm) do 
    described_class.new
  end

  after do
    # Butina - kitaip mutant sumauna workgroups.yml faila
    hash = { '453' => { 'project_id' => '3324', 'group_name' => 'Test',
                        'members' => ['jhon@gmail.com'], 'tasks' => 'sleep' } }
    File.open('workgroups.yml', 'w') { |fl| fl.write hash.to_yaml.gsub('---', '') }
  end

  it do
    groups = YAML.load_file('workgroups.yml')
    expect(wgm.load_yaml).to eq groups
  end

  it do
    expect(wgm.save_group(WorkGroup.new('100', 'someid', 'name', 'terminate'))).to be true
  end

  it do
    wgm.save_group(WorkGroup.new('100', 'someid', 'name', 'terminate'))
    hash = YAML.load_file('workgroups.yml')
    expect(hash['100']['project_id']).to eq 'someid'
  end

  it do
    expect(wgm.delete_group(WorkGroup.new('453', 'someid', 'name', 'terminate'))).to be true
  end

  it do
    wgm.delete_group(WorkGroup.new('453', 'someid', 'name', 'terminate'))
    hash = YAML.load_file('workgroups.yml')
    expect(hash).to be false # empty file
  end

  it do
    expect(wgm.delete_group(WorkGroup.new('100', 'someid', 'name', 'terminate'))).to be false
  end
end
