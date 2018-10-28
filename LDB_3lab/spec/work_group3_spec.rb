# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/work_group'
require_relative '../lib/user'

describe WorkGroup do
  let(:group) { described_class.new }

  it 'always returns non-nil value' do
    expect(group.parm_manager).not_to be nil
  end

  it 'non-nil as well' do
    expect(group.parm_work_group_name).not_to be nil
  end

  it 'is always non-nil' do
    expect(group.add_member(User.new)).not_to be nil
  end

  it 'does not return nil' do
    expect(group.remove_member(User.new)).not_to be nil
  end

  it 'default name setting' do
    expect(group.parm_work_group_name).to eq 'Default_work_group_' +
                                             Date.today.to_s
  end

  it 'group is initially fine' do
    expect(group.deleted?).to be false
  end

  it 'status changes correctly' do
    group.deleted_status_setter
    expect(group.deleted?).to be true
  end
end
