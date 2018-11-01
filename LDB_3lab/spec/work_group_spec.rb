# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/work_group'
require_relative '../lib/user'

describe WorkGroup do
  let :wg do
    described_class.new('453', '3324', 'Test', ['tst'])
  end

  context 'when a member is being removed from the work_group' do
    it 'true when an existing member gets removed from the work_group' do
      group = described_class.new('453', '3324', 'Test', 'sleep')
      e = 'jhonpeterson@mail.com'
      vart = User.new(name: 'Jhon', last_name: 'Peterson', email: e)
      group.add_group_member(vart)
      expect(group.remove_group_member(vart)).to be true
    end

    it 'false if trying to remove non-existing member from the work_group' do
      group = described_class.new('453', '3324', 'Test', 'sleep')
      e = 'jhonpeterson@mail.com'
      vart = User.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(group.remove_group_member(vart)).to be false
    end
  end

  it 'name is set correctly' do
    group = described_class.new('453', '3324', 'Test', 'sleep')
    group.data_setter('group_name', 'newname')
    expect(group.data_getter('group_name')).to eq 'newname'
  end

  it do
    expect(wg.add_group_task('mytask')).to be true
  end

  it do
    wg.add_group_task('mytask')
    expect(wg.data_getter('tasks')).to eq %w[tst mytask]
  end

  it do
    expect(wg.delete_group_task(0)).to be true
  end

  it do
    wg.delete_group_task(0)
    expect(wg.data_getter('tasks')).to eq []
  end

  it do
    expect(wg.delete_group_task(-1)).to be false
  end

  it do
    expect(wg.delete_group_task(999)).to be false
  end

  it 'non-nil as well' do
    group = described_class.new('453', '3324', 'Test', 'sleep')
    expect(group.data_getter('group_name')).not_to be nil
  end

  it 'is always non-nil' do
    group = described_class.new('453', '3324', 'Test', 'sleep')
    e = 'jhonpeterson@mail.com'
    usr = User.new(name: 'Jhon', last_name: 'Peterson', email: e)
    expect(group.add_group_member(usr)).not_to be nil
  end

  it 'does not return nil' do
    group = described_class.new('453', '3324', 'Test', 'sleep')
    e = 'jhonpeterson@mail.com'
    usr = User.new(name: 'Jhon', last_name: 'Peterson', email: e)
    expect(group.remove_group_member(usr)).not_to be nil
  end

  context 'when a new member is being added to the work_group' do
    it 'Returns true when a new member is added to the work_group' do
      group = described_class.new('453', '3324', 'Test', 'sleep')
      e = 'jhonpeterson@mail.com'
      vart = User.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(group.add_group_member(vart)).to be true
    end

    it 'false if work group member is added again to the same work_group' do
      group = described_class.new('453', '3324', 'Test', 'sleep')
      e = 'jhonpeterson@mail.com'
      vart = User.new(name: 'Jhon', last_name: 'Peterson', email: e)
      group.add_group_member(vart)
      expect(group.add_group_member(vart)).to be false
    end

    it 'Returns false when invalid User object is passed' do
      group = described_class.new('453', '3324', 'Test', 'sleep')
      e = 'jhonpeterson@mail.com'
      usr = User.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(group.add_group_member(usr)).not_to be nil
    end
  end

  it 'removing non-member is not allowed' do
    group = described_class.new('453', '3324', 'Test', 'sleep')
    e = 'jhonpeterson@mail.com'
    usr = User.new(name: 'Jhon', last_name: 'Peterson', email: e)
    group.remove_group_member(usr)
    expect(group.remove_group_member(usr)).to be false
  end

  it 'correctly gets the name' do
    group = described_class.new('453', '3324', 'Test', 'sleep')
    group.data_setter('group_name', 'name')
    expect(group.data_getter('group_name')).to eq 'name'
  end
end
