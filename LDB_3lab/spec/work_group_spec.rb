# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/work_group'
require_relative '../lib/user'

describe WorkGroup do
  let :wg do
    described_class.new('453', '3324', 'Test')
  end

  after do
    # Butina - kitaip mutant sumauna users.yml faila ir klasiu kintamuosius.
    hash = { '453' => { 'project_id' => '3324', 'group_name' => 'Test',
                        'members' => 'jhno@mail.com', 'tasks' => 'sleep' } }
    File.open('workgroups.yml', 'w') do |fl|
      fl.write hash.to_yaml.gsub('---', '')
    end
  end

  context 'when a member is being removed from the work_group' do
    it 'true when an existing member gets removed from the work_group' do
      group = described_class.new('453', '3324', 'Test')
      e = 'jhonpeterson@mail.com'
      vart = User.new(name: 'Jhon', last_name: 'Peterson', email: e)
      group.add_group_member(vart)
      expect(group.remove_group_member(vart)).to be true
    end

    it 'false if trying to remove non-existing member from the work_group' do
      group = described_class.new('453', '3324', 'Test')
      e = 'jhonpeterson@mail.com'
      vart = User.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(group.remove_group_member(vart)).to be false
    end

    it 'member is actually removed' do
      vart = User.new(email: 'jhno@mail.com')
      wg.add_group_member(vart)
      wg.remove_group_member(vart)
      expect(wg.members_getter).to eq []
    end
  end

  it 'name is set correctly' do
    group = described_class.new('453', '3324', 'Test')
    group.data_setter('group_name', 'newname')
    expect(group.data_getter('group_name')).to eq 'newname'
  end

  it 'is possible to add a new task' do
    expect(wg.add_group_task('mytask')).to be true
  end

  it 'the task is retrieved' do
    wg.add_group_task('mytask')
    expect(wg.tasks_getter).to eq %w[mytask]
  end

  it 'deleting existing index works' do
    expect(wg.remove_group_task(0)).to be true
  end

  it 'deleted tasks are actually removed' do
    wg.add_group_task('mytask')
    wg.remove_group_task('mytask')
    expect(wg.tasks_getter).to eq []
  end

  it 'non-nil as well' do
    group = described_class.new('453', '3324', 'Test')
    expect(group.data_getter('group_name')).not_to be nil
  end

  it 'is always non-nil' do
    group = described_class.new('453', '3324', 'Test')
    e = 'jhonpeterson@mail.com'
    usr = User.new(name: 'Jhon', last_name: 'Peterson', email: e)
    expect(group.add_group_member(usr)).not_to be nil
  end

  it 'does not return nil' do
    group = described_class.new('453', '3324', 'Test')
    e = 'jhonpeterson@mail.com'
    usr = User.new(name: 'Jhon', last_name: 'Peterson', email: e)
    expect(group.remove_group_member(usr)).not_to be nil
  end

  context 'when a new member is being added to the work_group' do
    it 'Returns true when a new member is added to the work_group' do
      group = described_class.new('453', '3324', 'Test')
      e = 'jhonpeterson@mail.com'
      vart = User.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(group.add_group_member(vart)).to be true
    end

    it 'false if work group member is added again to the same work_group' do
      group = described_class.new('453', '3324', 'Test')
      e = 'jhonpeterson@mail.com'
      vart = User.new(name: 'Jhon', last_name: 'Peterson', email: e)
      group.add_group_member(vart)
      expect(group.add_group_member(vart)).to be false
    end

    it 'Returns false when invalid User object is passed' do
      group = described_class.new('453', '3324', 'Test')
      e = 'jhonpeterson@mail.com'
      usr = User.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(group.add_group_member(usr)).not_to be nil
    end
  end

  it 'correctly gets the name' do
    group = described_class.new('453', '3324', 'Test')
    group.data_setter('group_name', 'name')
    expect(group.data_getter('group_name')).to eq 'name'
  end

  context 'assembles the hash correctly' do
    before do
      wg.add_group_member(User.new(email: 'some@mail.com'))
      wg.add_group_task('mytask')
    end

    it 'assembles the hash correctly' do
      expect(wg.to_hash).to eq '453' => { 'project_id' => '3324',
                                          'group_name' => 'Test',
                                          'members' => ['some@mail.com'],
                                          'tasks' => ['mytask'] }
    end
  end
end
