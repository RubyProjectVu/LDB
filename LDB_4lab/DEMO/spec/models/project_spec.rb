# frozen_string_literal: true

require_relative 'custom_matcher'
require_relative '../rails_helper'

describe Project do
  fixtures :all

  let(:pr) {
    pr = double
    allow(pr).to receive(:name=)
    allow(pr).to receive(:save)
    allow(pr).to receive(:find_test) { Project.find_by(name: 'test') }
    allow(pr).to receive(:find_proj).and_return(Project.find_by(name: 'Projektas1'))
    allow(pr).to receive(:exec_deleted_status)
    allow(pr).to receive(:set_deleted_status)
    pr
  }

  context 'when project is validating its metadata, status, owner' do
    it 'first time marking as deleted' do
      pr.name = 'test'
      pr.save
      expect(pr).not_to receive(:exec_deleted_status)
      pr.find_test
      pr.set_deleted_status
    end

    it 'second time marking as deleted' do
      # Projektas1 is already marked as deleted
      expect(pr.find_proj).to receive(:exec_deleted_status)
      pr.find_proj.set_deleted_status
    end
  end

  it 'has its owner defined as the user after creation by default' do
    described_class.create(name: 'test', manager: 'guy')
    proj = Project.find_by name: 'test'
    expect(proj.data_getter('manager')).to eq 'guy'
  end

  it 'deleted status change' do
    described_class.create(name: 'test', manager: 'guy')
    proj = Project.find_by(name: 'test')
    proj.set_deleted_status
    expect(proj.parm_project_status).to eq 'Deleted'
  end

  it 'setting for deletion works' do
    Project.create(name: 'test')
    pr = Project.find_by(name: 'test')
    expect(pr.set_deleted_status).to be true
  end

  it 'can add a new member' do
    Project.create(name: 'test')
    pr = Project.find_by name: 'test'
    expect(pr.add_member('somemail')).to be true
  end

  it 'can remove a member' do
    Project.create(name: 'test2')
    proj = Project.find_by name: 'test2'
    proj.add_member('userm')
    expect((Project.find_by name: 'test2').remove_member('userm')).to be true
  end

  it 'always return truthy status' do
    Project.create(name: 'test', status: 'Proposed')
    pr = Project.find_by name: 'test'
    expect(pr.parm_project_status).to be_truthy
  end

  it 'cannot change to nondeterministic status' do
    Project.create(name: 'test')
    pr = Project.find_by name: 'test'
    expect(pr.parm_project_status('n')).to be false
  end

  it 'cancelled status is set correctly' do
    Project.create(name: 'test')
    pr = Project.find_by name: 'test'
    pr.parm_project_status('Cancelled')
    expect(Project.find_by(name: 'test').status).to eq 'Cancelled'
  end

  it 'in progress is set correctly' do
    Project.create(name: 'test')
    pr = Project.find_by name: 'test'
    pr.parm_project_status('In progress')
    expect(Project.find_by(name: 'test').status).to eq 'In progress'
  end

  it 'members actually get saved' do
    Project.create(name: 'test')
    pr = Project.find_by name: 'test'
    pr.add_member('othermail')
    pr.add_member('somemail')
    pr = Project.find_by name: 'test'
    expect(pr.members_getter).to eq ['othermail', 'somemail']
  end

  it 'cannot remove non-existing member' do
    Project.create(name: 'test')
    Project.find_by(name: 'test').add_member('somemail')
    expect(Project.find_by(name: 'test').remove_member('nomail')).to be false
  end

  it 'postponed is set correctly' do
    Project.create(name: 'test')
    pr = Project.find_by name: 'test'
    pr.parm_project_status('Postponed')
    expect(Project.find_by(name: 'test').status).to eq 'Postponed'
  end

  it 'suspended is set correctly' do
    Project.create(name: 'test')
    pr = Project.find_by name: 'test'
    pr.parm_project_status('Suspended')
    expect(Project.find_by(name: 'test').status).to eq 'Suspended'
  end

  it 'proposed is set correctly' do
    Project.create(name: 'test')
    pr = Project.find_by name: 'test'
    pr.parm_project_status('Proposed')
    expect(Project.find_by(name: 'test').status).to eq 'Proposed'
  end
end
