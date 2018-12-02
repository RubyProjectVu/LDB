# frozen_string_literal: true

require_relative 'custom_matcher'
require_relative '../rails_helper'

describe ProjectManager do
  let(:pm) { described_class.new }

  let(:pm) do
    pm = described_class
    testProj = Project.find_by name: 'test'
    allow(pm).to receive(:set_project_description).with(testProj).and_return("Project description was funny")
    pm
  end
  
  it 'deleting an existing project' do
    Project.create(name: 'test', manager: 'guy', status: 'Proposed', budget: 0)
    id = (Project.find_by name: 'test').id
    expect(pm.delete_project(id)).to be true
  end

  it 'currently - no active projects' do
    # TODO: active project checking will be implemented later
    expect(pm.active_projects_present?).to be false
  end

  it 'project is actually written' do
    pm.save_project('test', 'guy')
    id = (Project.find_by name: 'test').id
    expect(pm.load_project(id)).to eq ['test', 'guy', nil, nil]
  end

  it 'project is actually removed' do
    pm.save_project('test', 'guy')
    id = (Project.find_by name: 'test').id
    pm.delete_project(id)
    expect(pm.load_project(id)).to be false
  end

  it 'grabs name by id' do
    pm.save_project('test', 'guy')
    id = (Project.find_by name: 'test').id
    obj = pm.load_project(id)
    expect(obj[0]).to match('test')
  end

  it 'grabs manager by id' do
    pm.save_project('test', 'guy')
    id = (Project.find_by name: 'test').id
    obj = pm.load_project(id)
    expect(obj[1]).to match('guy')
  end

  it 'grabs status by id' do
    pm.save_project('test', 'guy')
    id = (Project.find_by name: 'test').id
    obj = pm.load_project(id)
    expect(obj[2]).to eq nil
  end

  it 'lists ids and manes of projects' do
    id = (Project.find_by name: 'Projektas2').id
    id2 = (Project.find_by name: 'Projektas1').id
    expect(pm.list_projects)
      .to match_array ["#{id}:Projektas2", "#{id2}:Projektas1"]
  end
end
