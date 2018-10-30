# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/project'
require_relative '../lib/user'

describe Project do
  let(:pr) { described_class.new }
  let(:usr) { User.new }

  it 'has its owner defined as the user after creation by default' do
    proj = described_class.new
    expect(proj.data_getter('manager')).to eq Etc.getlogin
  end

  it do
    pr.set_deleted_status
    expect(pr.parm_project_status).to eq 'Deleted'
  end
end
