# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/project'
require_relative '../lib/user'

describe Project do
  let(:pr) { described_class.new }
  let(:usr) { User.new }

  it do
    pr.set_deleted_status
    expect(pr.set_deleted_status).to be false
  end

  it do
    expect(pr.data_getter('manager')).to be_truthy
  end

  it do
    User.new(email: 'othermail')
    pr.add_member('othermail')
    pr.add_member('somemail')
    pr.remove_member('othermail')
    expect(pr.members_getter).to eq ['somemail']
  end
end
