# frozen_string_literal: true

#require 'simplecov'
#SimpleCov.start

# require 'app/models/project'
require_relative 'custom_matcher'
# require_relative '../application_record'
require_relative '../rails_helper'

describe Project do
  let(:pr) { 
    pr = double(:Project)
    allow(pr).to receive(:add_member)
    allow(pr).to receive(:remove_member)
    allow(pr).to receive(:set_deleted_status)
    allow(pr).to receive(:parm_project_status)
    allow(pr).to receive(:data_getter)
    pr
  }
  let(:usr) { User.new }

  context 'when project is validating its metadata, status, owner' do
    it 'first time marking as deleted' do
      proj = described_class.new
      proj.name = 'test'
      proj.save
      expect(ProjectManager.new).not_to receive(:delete_project)
      proj.set_deleted_status
    end

    it 'second time marking as deleted' do
      described_class.create(name: 'test')
      proj = (Project.find_by name: 'test').id
      proj.set_deleted_status
      expect(ProjectManager.new).to receive(:delete_project)
      proj.set_deleted_status
    end
  end

  context 'when a member is being removed from the project' do
    it 'True when an existing member gets removed from the project' do
      proj = described_class.new
      e = 'jhonpeterson@mail.com'
      # User.new(name: 'Jhon', last_name: 'Peterson', email: e)
      proj.add_member(e)
      expect(proj.remove_member(e)).to be true
    end

    it 'returns false when nonmember is being removed from the project' do
      proj = described_class.new
      e = 'jhonpeterson@mail.com'
      User.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(proj.remove_member(e)).to be false
    end
  end

  context 'when a new member is being added to the project' do
    it 'returns true when a new member is added to the project' do
      proj = described_class.new
      e = 'jhonpeterson@mail.com'
      User.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(proj.add_member(e)).to be true
    end

    it 'Return false when existing member is being added to the project' do
      proj = described_class.new
      e = 'jhonpeterson@mail.com'
      User.new(name: 'Jhon', last_name: 'Peterson', email: e)
      proj.add_member(e)
      expect(proj.add_member(e)).to be false
    end
  end

  it 'has its owner defined as the user after creation by default' do
    described_class.create(name: 'test', manager: 'guy')
    proj = Project.find_by name: 'test'
    expect(proj.data_getter('manager')).to eq 'guy'
  end

  it 'deleted status change' do
    described_class.create(name: 'test', manager: 'guy')
    proj = Project.find_by name: 'test'
    proj.set_deleted_status
    expect(proj.parm_project_status).to eq 'Deleted'
  end

  it 'setting for deletion works' do
    Project.create(name: 'test')
    pr = Project.find_by name: 'test'
    expect(pr.set_deleted_status).to be true
  end

  it 'can add a new member' do
    Project.create(name: 'test')
    pr = Project.find_by name: 'test'
    expect(pr.add_member('somemail')).to be true
  end

  it 'non-existing member removal' do
    Project.create(name: 'test')
    pr = Project.find_by name: 'test'
    expect(pr.remove_member('noid')).to be false
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
    expect(pr.parm_project_status).to eq 'Cancelled'
  end

  it 'status is return in addition to being set' do
    Project.create(name: 'test')
    pr = Project.find_by name: 'test'
    expect(pr.parm_project_status('Cancelled')).to eq 'Cancelled'
  end

  it 'in progress is set correctly' do
    Project.create(name: 'test')
    pr = Project.find_by name: 'test'
    expect(pr.parm_project_status('In progress')).to eq 'In progress'
  end

  it 'member lists are not mixed up' do
    Project.create(name: 'test')
    # puts Project.all Not empty
    pr = Project.find_by name: 'test'
    pr.add_member('othermail')
    pr.add_member('somemail')
# Empty?
puts ProjectMember.all
puts 'multiple members:'
puts pr.members_getter
  end

  it 'cannot remove non-existing member' do
    expect(pr.remove_member('somemail')).to be false
  end

  it 'initial status is proposed' do
    expect(pr.parm_project_status).to eq 'Proposed'
  end

  it 'default name is .. well, default project' do
    expect(pr.data_getter('name')).to eq 'Default_project_' + Date.today.to_s
  end

  it 'name is set correctly' do
    pr.data_setter('name', 'newname')
    expect(pr.data_getter('name')).to eq 'newname'
  end

  it 'postponed is set correctly' do
    expect(pr.parm_project_status('Postponed')).to eq 'Postponed'
  end

  it 'suspended is set correctly' do
    expect(pr.parm_project_status('Suspended')).to eq 'Suspended'
  end

  it 'proposed is set correctly' do
    expect(pr.parm_project_status('Proposed')).to eq 'Proposed'
  end

  it 'project is converted to hash correctly' do
    pr2.parm_project_status('Cancelled')
    expect(pr2.to_hash).to eq '3' => { 'name' => '1', 'manager' => '2',
                                       'members' => '4',
                                       'status' => 'Cancelled' }
  end

  it 'id is never nil' do
    expect(described_class.new.data_getter('id')).not_to be_nil
  end

  it 'id is always a number' do
    id = described_class.new.data_getter('id')
    expect(id).to be_kind_of(Numeric)
  end
end
