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
    File.open('workgroups.yml', 'w') do |fl|
      fl.write hash.to_yaml.gsub('---', '')
    end
  end

  it 'saves a new group' do
    expect(wgm.save_group(WorkGroup.new('100', 'someid', 'name'))).to be true
  end

  it 'new group is actually written to file' do
    wgm.save_group(WorkGroup.new('100', 'someid', 'name'))
    hash = YAML.load_file('workgroups.yml')
    expect(hash['100']['project_id']).to eq 'someid'
  end

  it 'deleting an existing group' do
    expect(wgm.delete_group('453')).to be true
  end

  it 'deleted group is actually removed' do
    wgm.delete_group('453')
    hash = YAML.load_file('workgroups.yml')
    expect(hash).to be false # empty file
  end

  it 'stopping removal of non-existing group' do
    expect(wgm.delete_group(WorkGroup.new('1', 'someid', 'name'))).to be false
  end
end
