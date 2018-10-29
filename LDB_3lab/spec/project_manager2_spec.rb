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
    File.open('projects.yml', 'w') { |fl| fl.write hash.to_yaml.gsub('---', '') }
  end

  it do
    # TODO active project checking will be implemented later
    expect(pm.active_projects_present?).to be false
  end

  it do
    pm.save_project(Project.new(project_name: 'name', num: 'id'))
    hash = YAML.load_file('projects.yml')
    expect(hash['id']['name']).to eq 'name'
  end

  it do
    pm.delete_project(Project.new(num: 'someid'))
    hash = YAML.load_file('projects.yml')
    expect(hash['someid']).to be nil
  end
end
