# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/work_group'
require_relative '../lib/user'

describe WorkGroup do
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
end
