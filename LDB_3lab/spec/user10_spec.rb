# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/user'
require_relative '../lib/project'
require_relative '../lib/work_group'

describe User do
  let(:usr) { described_class.new }

  it 'active projects get actually included' do
    proj = Project.new
    proj.parm_project_status('In progress')
    usr.add_project(proj.parm_project_name,
                    proj.parm_project_status)
    expect(usr.active_projects_present?).not_to be nil
  end

  it 'no active projects initially' do
    expect(usr.active_projects_present?).to be false
  end

  it 'last used object is empty' do
    expect(usr.data_getter('lobject')).to eq ''
  end

  it 'no active projects actually there' do
    proj = Project.new
    proj.parm_project_status('Cancelled')
    usr.add_project(proj.parm_project_name,
                    proj.parm_project_status)
    expect(usr.active_projects_present?).to be false
  end
end
