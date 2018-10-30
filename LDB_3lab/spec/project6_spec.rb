# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/project'
require_relative '../lib/user'

describe Project do
  let(:pr) { described_class.new }
  let(:usr) { User.new }

  it do
    expect(pr.parm_project_status).to be_truthy
  end

  it do
    expect(pr.parm_project_status('n')).to be false
  end

  it do
    pr.parm_project_status('Cancelled')
    expect(pr.parm_project_status).to eq 'Cancelled'
  end

  it do
    expect(pr.parm_project_status('Cancelled')).to eq 'Cancelled'
  end

  it do
    expect(pr.parm_project_status('In progress')).to eq 'In progress'
  end
end
