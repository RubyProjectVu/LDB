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
    id = Project.find_by(name: 'Projektas2').id
    { :wg => { :projid => id, :name => 'naujas', :budget => '121' } }
  end

  it 'VIEWS TEST: addmem renders view' do
    post :addmem
    expect(response).to render_template(:addmem)
  end

  it 'VIEWS TEST: create witn no params renders view' do
    expect(subject).to receive(:render).and_call_original
    get :create, params: { }
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

  context 'new wg created' do
    before do
      allow_any_instance_of(described_class).to receive(:params).and_return(new_proj)
    end

    it 'actually creates the group' do
      subject.send(:create)
      wg = WorkGroup.find_by(name: 'naujas', projid: new_proj[:wg][:projid])
      expect(wg).not_to be nil
    end

    it 'actually sets its budget' do
      subject.send(:create)
      wg = WorkGroup.find_by(name: 'naujas', projid: new_proj[:wg][:projid])
      expect(wg.budget).to eq 121
    end

    it 'actually sets projects budget' do
      subject.send(:create)
      proj = Project.find_by(id: new_proj[:wg][:projid])
      expect(proj.budget).to eq 4879.5
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
    id = WorkGroup.find_by(name: 'Trecia grupe').id
    hash = { :id => id }
    post :destroy, params: hash
    wg = WorkGroup.find_by(name: 'Trecia grupe')
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
