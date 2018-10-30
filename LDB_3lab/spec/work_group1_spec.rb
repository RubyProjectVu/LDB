# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/work_group'
require_relative '../lib/user'

describe WorkGroup do
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
end
