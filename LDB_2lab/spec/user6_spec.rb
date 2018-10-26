# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/user'
require_relative '../lib/system'
require_relative '../lib/project'
require_relative '../lib/work_group'

describe User do
  let(:usr) { described_class.new }

  it do
    proj = usr.create_project('name', 'metadata.txt')
    expect(proj.parm_project_name).to eq 'name'
  end

  it do
    wg = usr.create_work_group('name')
    expect(wg.parm_work_group_name).to eq 'name'
  end

  it do
    usr.create_project('pname', 'meta.txt')
    expect(usr.data_getter('lobject')).to eq 'Project'
  end

  it do
    usr.create_work_group('wgname')
    expect(usr.data_getter('lobject')).to eq 'WGroup'
  end

  it do
    proj = Project.new
    proj.parm_project_status('In progress')
    usr.add_project(proj.parm_project_name,
                    proj.parm_project_status)
    expect(usr.active_projects_present?).to be true
  end
end
