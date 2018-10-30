# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/work_group'
require_relative '../lib/user'
require 'date'

describe WorkGroup do
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
