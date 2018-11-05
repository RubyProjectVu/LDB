# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/work_group_manager'
require_relative '../lib/work_group'
require_relative 'custom_matcher'
require 'date'

describe WorkGroupManager do
  let(:wgm) do
    described_class.new
  end

  after do
    # Butina - kitaip mutant sumauna workgroups.yml faila
    hash = { '453' => { 'project_id' => '3324', 'group_name' => 'Test',
                        'members' => ['jhon@mail.com'], 'tasks' => 'sleep' } }
    File.open('workgroups.yml', 'w') do |fl|
      fl.write hash.to_yaml.gsub('---', '')
    end
  end

  it 'saves a new group' do
    expect(wgm.save_group(WorkGroup.new('100', 'someid', 'name'))).to be_truthy
  end

  it 'new group is correctly saved to a file' do
    wg = WorkGroup.new('100', 'someid', 'name')
    wgm.save_group(wg)
    expect(wg.to_hash).to be_correctly_saved('workgroups.yml');
  end

  it 'rewriting existing group doesn\'t create duplicates' do
    wgm.save_group(WorkGroup.new('453', 'someid', 'name'))
    file = 'workgroups.yml'
    key = '453'
    expect(key).to is_key_unique(file)
  end

  it 'deleting an existing group' do
    expect(wgm.delete_group('453')).to be true
  end

  it 'last group is removed and file is empty' do
    wgm.delete_group('453')
    hash = YAML.load_file('workgroups.yml')
    expect(hash).to be false # empty file
  end

  it 'deleted group is actually removed' do
    wgm.save_group(WorkGroup.new('100', 'someid', 'name'))
    described_class.new.delete_group('453')
    hash = YAML.load_file('workgroups.yml')
    expect(hash).not_to have_key('453')
  end
end
