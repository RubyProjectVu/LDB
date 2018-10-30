# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/work_group'
require_relative '../lib/user'

describe WorkGroup do
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
end
