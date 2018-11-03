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
                           'members' => %w[john steve harry],
                           'status' => 'Suspended' } }
    File.open('projects.yml', 'w') do |fl|
      fl.write hash.to_yaml.gsub('---', '')
    end
  end

  it 'deleting an existing project' do
    expect(pm.delete_project(Project.new(num: 'someid'))).to be true
  end

  it 'file is clean of dashes after deletion' do
    pm.delete_project(Project.new(num: 'someid'))
    expect(File.read('projects.yml').match?(/---/)).to be false
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

  it 'false on non-existing id' do
    expect(pm.load_project('noid')).to be false
  end

  it 'grabs name by id' do
    obj = pm.load_project('someid')
    expect(obj.data_getter('name')).to match('projektas')
  end

  it 'grabs manager by id' do
    obj = pm.load_project('someid')
    expect(obj.data_getter('manager')).to match('john')
  end

  it 'grabs members by id' do
    obj = pm.load_project('someid')
    expect(obj.members_getter).to match_array %w[john steve harry]
  end

  it 'grabs id by id' do
    obj = pm.load_project('someid')
    expect(obj.data_getter('id')).to satisfy do |id|
      id.eql?('someid')
    end
  end

  it 'grabs status by id' do
    obj = pm.load_project('someid')
    expect(obj.parm_project_status).to eq 'Suspended'
  end

  it 'lists ids and manes of projects' do
    expect(pm.list_projects).to match_array %w[someid:projektas]
  end
end