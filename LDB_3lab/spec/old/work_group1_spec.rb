# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/work_group'
require_relative '../lib/user'

describe WorkGroup do
  context 'when a member is being removed from the work_group' do
    it 'true when an existing member gets removed from the work_group' do
      group = described_class.new
      e = 'jhonpeterson@mail.com'
      vart = User.new(name: 'Jhon', last_name: 'Peterson', email: e)
      group.add_member(vart)
      expect(group.remove_member(vart)).to be true
    end

    it 'false if trying to remove non-existing member from the work_group' do
      group = described_class.new
      e = 'jhonpeterson@mail.com'
      vart = User.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(group.remove_member(vart)).to be false
    end
  end

  context 'when work group is validating its name, and owner' do
    it 'initially defines creator as am owner' do
      expect(described_class.new.parm_manager).to eq Etc.getlogin
    end
  end

  it 'name is set correctly' do
    group = described_class.new
    group.parm_work_group_name('newname')
    expect(group.parm_work_group_name).to eq 'newname'
  end
end
