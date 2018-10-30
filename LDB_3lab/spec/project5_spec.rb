# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/project'
require_relative '../lib/user'

describe Project do
  let(:pr) { described_class.new }
  let(:usr) { User.new }

  it do
    expect(pr.set_deleted_status).to be true
  end

  it do
    expect(pr.add_member('somemail')).to be true
  end

  it do
    # id is blank
    expect(pr.remove_member(usr)).to be false
  end

  it do
    User.new(email: 'somemail')
    pr.add_member('somemail')
    expect(pr.remove_member('somemail')).to be true
  end
end
