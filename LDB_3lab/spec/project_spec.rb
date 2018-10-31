# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/project'
require_relative '../lib/user'

describe Project do
  let(:pr) { described_class.new }
  let(:usr) { User.new }

  context 'when project is validating its metadata, status, owner' do
    it 'has its owner set correctly' do
      proj = described_class.new
      proj.data_setter('manager', 'some name')
      expect(proj.data_getter('manager')).to eq 'some name'
    end

    it 'sets/returns valid status' do
      proj = described_class.new
      proj.parm_project_status('Proposed')
      expect(proj.parm_project_status).to eq 'Proposed'
    end
  end

  context 'when a member is being removed from the project' do
    it 'True when an existing member gets removed from the project' do
      proj = described_class.new
      e = 'jhonpeterson@mail.com'
      User.new(name: 'Jhon', last_name: 'Peterson', email: e)
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
    proj = described_class.new
    expect(proj.data_getter('manager')).to eq Etc.getlogin
  end

  it do
    pr.set_deleted_status
    expect(pr.parm_project_status).to eq 'Deleted'
  end

  it do
    expect(pr.set_deleted_status).to be true
  end

  it do
    expect(pr.add_member('somemail')).to be true
  end

  it do
    # id is blank
    expect(pr.remove_member(usr)).to be false
  end

  it do
    User.new(email: 'somemail')
    pr.add_member('somemail')
    expect(pr.remove_member('somemail')).to be true
  end

  it do
    expect(pr.parm_project_status).to be_truthy
  end

  it do
    expect(pr.parm_project_status('n')).to be false
  end

  it do
    pr.parm_project_status('Cancelled')
    expect(pr.parm_project_status).to eq 'Cancelled'
  end

  it do
    expect(pr.parm_project_status('Cancelled')).to eq 'Cancelled'
  end

  it do
    expect(pr.parm_project_status('In progress')).to eq 'In progress'
  end

  it do
    pr.set_deleted_status
    expect(pr.set_deleted_status).to be false
  end

  it do
    expect(pr.data_getter('manager')).to be_truthy
  end

  it do
    User.new(email: 'othermail')
    pr.add_member('othermail')
    pr.add_member('somemail')
    pr.remove_member('othermail')
    expect(pr.members_getter).to eq ['somemail']
  end

  it do
    expect(pr.remove_member('somemail')).to be false
  end

  it do
    expect(pr.parm_project_status).to eq 'Proposed'
  end

  it do
    expect(pr.data_getter('name')).to eq 'Default_project_' + Date.today.to_s
  end

  it do
    pr.data_setter('name', 'newname')
    expect(pr.data_getter('name')).to eq 'newname'
  end

  it do
    expect(pr.parm_project_status('Postponed')).to eq 'Postponed'
  end

  it do
    expect(pr.parm_project_status('Suspended')).to eq 'Suspended'
  end

  it do
    expect(pr.parm_project_status('Proposed')).to eq 'Proposed'
  end

  it do
    pr = described_class.new(project_name: '1', manager: '2', num: '3',
                             members: '4')
    pr.parm_project_status('Cancelled')
    expect(pr.to_hash).to eq '3' => { 'name' => '1', 'manager' => '2',
                                      'members' => '4',
                                      'status' => 'Cancelled' }
  end

  it do
    expect(described_class.new.data_getter('id')).not_to be nil
  end

  it do
    id = described_class.new.data_getter('id')
    expect(id).to be_kind_of(Numeric)
  end
end
