require 'simplecov'
SimpleCov.start

require_relative '../work_group'
require_relative '../user'
require_relative '../system_project_logger'

describe WorkGroup do
  context 'when a member is being removed from the work_group' do
    it 'true when an existing member gets removed from the work_group' do
      group = described_class.new
      e = 'jhonpeterson@mail.com'
      vart = User.new(name: 'Jhon', last_name: 'Peterson', email: e)
      group.add_member(vart)
      expect(group.remove_member(vart)).to be true
    end

    it 'false if trying to remove non-existing member from the work_group' do
      group = described_class.new
      e = 'jhonpeterson@mail.com'
      vart = User.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(group.remove_member(vart)).to be false
    end

    # it 'Returns false when invalid User object is passed' do
    #  group = WorkGroup.new
    #  expect(group.remove_member(nil)).to be false
    # end
  end

  context 'when work group is validating its name, and owner' do
    it 'initially defines creator as am owner' do
      group = described_class.new
      expect(group.parm_manager).to eq Etc.getlogin
      # group.parm_manager('some name')
      # expect(group.parm_manager).to eq 'some name'
    end
  end
end
