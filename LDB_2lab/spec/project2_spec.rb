# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/project'
require_relative '../lib/user'

describe Project do
  let(:pr) { described_class.new }
  let(:usr) { User.new }

  context 'when a member is being removed from the project' do
    it 'True when an existing member gets removed from the project' do
      proj = described_class.new
      e = 'jhonpeterson@mail.com'
      vart = User.new(name: 'Jhon', last_name: 'Peterson', email: e)
      proj.add_member(vart)
      expect(proj.remove_member(vart)).to be true
    end

    it 'returns false when nonmember is being removed from the project' do
      proj = described_class.new
      e = 'jhonpeterson@mail.com'
      vart = User.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(proj.remove_member(vart)).to be false
    end
  end

  it 'is be able to remove itself if there are no active projects' do
    proj = described_class.new(project_name: 'Name')
    proj.parm_project_status('Postponed')
    usr = User.new
    usr.add_project(proj.parm_project_name, proj.parm_project_status)
    expect(usr.prepare_deletion).to be true
  end
end
