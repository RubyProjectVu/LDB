require 'simplecov'
SimpleCov.start

require_relative '../work_group'
require_relative '../user'
require_relative '../system_project_logger'

describe WorkGroup do
  context 'when a new member is being added to the work_group' do
    it 'Returns true when a new member is added to the work_group' do
      group = described_class.new
      e = 'jhonpeterson@mail.com'
      vart = User.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(group.add_member(vart)).to be true
    end

    it 'false if work group member is added again to the same work_group' do
      group = described_class.new
      e = 'jhonpeterson@mail.com'
      vart = User.new(name: 'Jhon', last_name: 'Peterson', email: e)
      group.add_member(vart)
      expect(group.add_member(vart)).to be false
    end

    # it 'Returns false when invalid User object is passed' do
    #  group = WorkGroup.new
    #  expect(group.add_member(nil)).to be false
    # end

    it do
      item = SystemProjectLogger.new(%w[projname 1410154])
      item.log_project_creation
    end
  end
end
