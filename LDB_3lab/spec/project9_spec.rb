# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/project'
require_relative '../lib/user'

describe Project do
  let(:pr) { described_class.new }
  let(:usr) { User.new }

  #it do
   # expect(pr.notify_subscribers(['value'])).to eq ['value']
  #end

  #it do
   # pr.add_subscriber('name', 'mail')
    #expect(pr.remove_subscriber('name')).to eq 'mail'
  #end

  #it do
   # pr.add_subscriber('name', 'mail')
    #expect(pr.add_subscriber('name', 'mail')).to be false
  #end

  it do
    expect(pr.parm_project_status('Postponed')).to eq 'Postponed'
  end

  it do
    expect(pr.parm_project_status('Suspended')).to eq 'Suspended'
  end

  it do
    expect(pr.parm_project_status('Proposed')).to eq 'Proposed'
  end
end
