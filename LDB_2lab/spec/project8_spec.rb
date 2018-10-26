# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/project'
require_relative '../lib/user'

describe Project do
  let(:pr) { described_class.new }
  let(:usr) { User.new }

  it do
    usr = User.new(email: 'somemail')
    expect(pr.remove_member(usr)).to be false
  end

  it do
    expect(pr.parm_project_status).to eq 'Proposed'
  end

  it do
    expect(pr.parm_project_name).to eq 'Default_project_' + Date.today.to_s
  end

  it do
    pr.parm_project_name('newname')
    expect(pr.parm_project_name).to eq 'newname'
  end

  it do
    pr.add_subscriber('name', 'email')
    expect(pr.notify_subscribers).to eq ['name']
  end
end
