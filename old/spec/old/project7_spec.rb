# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/project'
require_relative '../lib/user'

describe Project do
  let(:pr) { described_class.new }
  let(:usr) { User.new }

  it do
    pr1 = described_class.new(meta_filename: 'temp.txt')
    File.delete('temp.txt')
    expect(pr1.check_metadata).to be false
  end

  it do
    pr.set_deleted_status
    expect(pr.set_deleted_status).to be false
  end

  it do
    expect(pr.parm_manager).to be_truthy
  end

  it do
    expect(pr.remove_subscriber('name')).to be false
  end

  it do
    usr2 = User.new(email: 'othermail')
    pr.add_member(usr2)
    pr.add_member(User.new(email: 'somemail'))
    pr.remove_member(usr2)
    expect(pr.members_getter).to eq ['somemail']
  end
end
