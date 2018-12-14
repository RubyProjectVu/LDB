# frozen_string_literal: true

require_relative '../rails_helper'

describe WgsController do
  let(:new_mem_hsh) do
    id = WorkGroup.find_by(name: 'Darbo grupe').id
    { :wg => { :member => 'naujas' }, :id => id }
  end

  let(:new_tsk_hsh) do
    id = WorkGroup.find_by(name: 'Antra grupe').id
    { :wg => { :task => 300 }, :id => id }
  end

  let(:new_proj) do
    id = 102050
    { :wg => { :projid => id, :name => 'Trecia grupe', :budget => '121' } }
  end

  it 'VIEWS TEST: addmem renders view' do
    post :addmem
    expect(response).to render_template(:addmem)
  end

  it 'member is actually removed' do
    post :remmem, params: { :member => 'some@mail.com', :id => 5020 }
    wgm = WorkGroupMember.find_by(wgid: 5020)
    expect(wgm).to be nil
  end

  it 'task is actually removed' do
    id = WorkGroup.find_by(name: 'Darbo grupe').id
    post :remtsk, params: { :task => 58, :id => 5050 }
    wgt = WorkGroupTask.find_by(wgid: 5050, task: 58)
    expect(wgt).to be nil
  end

  it 'empty params - no creation. covers mutation \'-if\'' do
    expect {visit 'wgs/create'}.not_to raise_error(ActionController::ParameterMissing)
  end

  context 'new wg created' do
    before do
      allow_any_instance_of(described_class).to receive(:params).and_return(new_proj)
    end

    it 'actually creates the group' do
      subject.send(:create)
      wg = WorkGroup.find_by(name: 'Trecia grupe', projid: new_proj[:wg][:projid])
      expect(wg).not_to be nil
    end

    it 'actually sets its budget' do
      subject.send(:create)
      wg = WorkGroup.find_by(name: 'Trecia grupe', projid: new_proj[:wg][:projid])
      expect(wg.budget).to eq 121
    end

    it 'actually sets projects budget' do
      subject.send(:create)
      proj = Project.find_by(id: new_proj[:wg][:projid])
      expect(proj.budget).to eq 34879.11
    end
  end

  context 'new member created' do
    before do
      allow_any_instance_of(described_class).to receive(:params).and_return(new_mem_hsh)
    end

    it 'member is actually added' do
      subject.send(:addmem)
      wgm = WorkGroupMember.find_by(wgid: new_mem_hsh[:id], member: 'naujas')
      expect(wgm).not_to be nil
    end
  end

  context 'new task created' do
    before do
      allow_any_instance_of(described_class).to receive(:params).and_return(new_tsk_hsh)
    end

    it 'task is actually added' do
      subject.send(:addtsk)
      wgm = WorkGroupTask.find_by(wgid: new_tsk_hsh[:id], task: 300)
      expect(wgm).not_to be nil
    end
  end

  it 'actually removes wg' do
    hash = { :id => 5020 }
    post :destroy, params: hash
    wg = WorkGroup.find_by(id: 5020)
    expect(wg).to be nil
  end

  it 'removal resets the project\'s budget' do
    id = WorkGroup.find_by(name: 'Trecia grupe').id
    hash = { :id => id }
    post :destroy, params: hash
    proj = Project.find_by(id: 101050).budget
    expect(proj).to eq 5010
  end
end
