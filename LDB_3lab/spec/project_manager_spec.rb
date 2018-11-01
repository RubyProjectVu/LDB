# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/project_manager'
require_relative '../lib/project'

describe ProjectManager do
  let(:pm) { described_class.new }

  after do
    # Butina - kitaip mutant sumauna projects.yml faila ir klasiu kintamuosius.
    hash = { 'someid' => { 'name' => 'projektas', 'manager' => 'john',
                           'members' => ['john', 'steve', 'harry'],
                           'status' => 'Proposed' } }
    File.open('projects.yml', 'w') do |fl|
      fl.write hash.to_yaml.gsub('---', '')
    end
  end

  RSpec::Matchers.define :project_object_returned do |expected|
    match do |actual|
      proj = described_class.new.load_project(expected.data_getter('id'))
      obj = Project.new(project_name: proj.data_getter('name'),
                        manager: proj.data_getter('manager'),
                        num: expected.data_getter('id'),
                        members: proj.members_getter)
      if obj.data_getter('name').eql?(actual.data_getter('name')) &&
         obj.data_getter('manager').eql?(actual.data_getter('manager')) &&
         obj.data_getter('id').eql?(actual.data_getter('id')) &&
         obj.members_getter.eql?(actual.members_getter) &&
         obj.parm_project_status.eql?(actual.parm_project_status)
        return true
      end
      return false
    end
  end

  # it do Failed after rubocop fixes - review?
  # proj = Project.new(project_name: 'projektas', manager: 'john',
  # num: 'someid',
  # members: ['john', 'steve', 'harry'])
  # proj.parm_project_status('Proposed')
  # expect(proj).to project_object_returned(proj)
  # end

  it '' do
    proj = Project.new(project_name: 'projektas', manager: 'john',
                       num: 'someid', members: [])
    proj.parm_project_status('Proposed')
    expect(proj).not_to project_object_returned(proj)
  end

  it 'deleting an existing project' do
    expect(pm.delete_project(Project.new(num: 'someid'))).to be true
  end

  it 'creating an existing project id is a fail' do
    expect(pm.save_project(Project.new(num: 'someid'))).to be false
  end

  it 'can save new project' do
    expect(pm.save_project(Project.new(num: 'prid'))).to be true
  end

  it 'currently - no active projects' do
    # TODO: active project checking will be implemented later
    expect(pm.active_projects_present?).to be false
  end

  it 'project is actually written' do
    pm.save_project(Project.new(project_name: 'name', num: 'id'))
    hash = YAML.load_file('projects.yml')
    expect(hash['id']['name']).to eq 'name'
  end

  it 'project is actually removed' do
    pm.delete_project(Project.new(num: 'someid'))
    hash = YAML.load_file('projects.yml')
    expect(hash['someid']).to be nil
  end
end
