# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/work_group'
require_relative '../lib/user'
require_relative '../lib/system'
require 'date'

describe WorkGroup do
  let(:group) { described_class.new }

  it 'removing non-member is not allowed' do
    usr = User.new
    group.add_member(usr)
    group.remove_member(usr)
    expect(group.remove_member(usr)).to be false
  end

  it 'function always returns non-nil' do
    expect(group.deleted_status_setter).not_to be nil
  end

  it 'is enough to mark once as deleted' do
    group.deleted_status_setter
    expect(group.deleted_status_setter).to be false
  end

  it 'successfully marks as deleted' do
    expect(group.deleted_status_setter).to be true
  end

  it 'correctly gets the name' do
    group1 = described_class.new(work_group_name: 'name')
    expect(group1.parm_work_group_name).to eq 'name'
  end

  it 'correctly gets the manager' do
    group.parm_manager('newname')
    expect(group.parm_manager).to eq 'newname'
  end
end
