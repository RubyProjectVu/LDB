# frozen_string_literal: true

#require 'simplecov'
#SimpleCov.start

#require_relative '../lib/project_manager'
#require_relative '../lib/project'
require_relative 'custom_matcher'
require_relative '../rails_helper'

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

  it 'file is clean of dashes and brackets after deletion' do
    pm.delete_project(Project.new(num: 'someid'))
    # expect(File.read('projects.yml').match?(/---/)).to be false
    file = 'projects.yml'
    expect(file).not_to has_yml_nils
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
    expect(hash).to be false
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

  #context 'projects.yml state testing' do
   # before do
    #  proj = Project.new(project_name: 'tst', manager: 'tst',
     #                    num: 'tst', members: %w[tst tst])
      #proj.parm_project_status('Suspended')
      #described_class.new.save_project(proj)
      #described_class.new.delete_project(Project.new(num: 'someid'))
    #end

    #it 'checks saving' do
     # current = 'projects.yml'
      #state = 'state-projects.yml'
      #expect(current).to is_yml_identical(state)
    #end

    #it 'checks loading' do
     # hash = { 'tst' => { 'name' => 'tst', 'manager' => 'tst',
      #                    'members' => %w[tst tst],
       #                   'status' => 'Suspended' } }
      #expect(YAML.load_file('projects.yml')).to is_data_identical(hash)
    #end
  #end
end
