require 'simplecov'
SimpleCov.start

require_relative '../project'
require_relative '../user'

describe Project do
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

    # it 'Should return false when invalid User object is passed' do
    #  proj = Projektas.new
    #  expect(proj.remove_member(nil)).to be false
    # end
  end

  it 'is be able to remove itself if there are no active projects' do
    proj = described_class.new(project_name: 'Name')
    proj.parm_project_status('Postponed')
    usr = User.new
    usr.add_project(proj.parm_project_name, proj.parm_project_status)
    expect(usr.prepare_deletion).to be true
    # proj.parm_project_status('Postponed')
    # usr.change_project_status(proj.parm_project_name, 'Postponed')
    # expect(usr.prepare_deletion).to be true
  end
end
