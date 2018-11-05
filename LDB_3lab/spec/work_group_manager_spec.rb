# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/work_group_manager'
require_relative '../lib/work_group'
require_relative 'custom_matcher'
require 'date'
srand

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
    expect(wg.to_hash).to be_correctly_saved('workgroups.yml')
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

  context 'bunches up some workgroups together on same project' do
    before do
      grp = WorkGroup.new('newid', 'someid', 'name')
      grp.data_setter('budget', rand(100))
      described_class.new.save_group(grp)
    end

    it 'bunches up some workgroups together on same project' do
      expect(BudgetManager.new.budgets_getter('someid'))
        .to be_between(34_000, 36_000)
    end
  end

  context 'workgroups.yml state testing' do
    before do
      gr = WorkGroup.new('tst', 'someid', 'tst')
      gr.data_setter('budget', 101)
      gr.add_group_member(User.new(email: 'memb@r.tst'))
      gr.add_group_task('tst')
      described_class.new.save_group(gr)
      described_class.new.delete_group('453')
    end

    it 'checks saving' do
      current = 'workgroups.yml'
      state = 'state-workgroups.yml'
      expect(current).to is_yml_identical(state)
    end

    it 'checks loading' do
      hash = { 'tst' => { 'project_id' => 'someid', 'group_name' => 'tst',
                          'members' => ['memb@r.tst'], 'tasks' => ['tst'],
                          'budget' => 101 } }
      expect(YAML.load_file('workgroups.yml')).to is_data_identical(hash)
    end
  end
end
