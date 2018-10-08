require 'simplecov'
SimpleCov.start

require_relative '../project'
require_relative '../user'

describe Project do
  context 'when a new member is being added to the project' do
    it 'returns true when a new member is added to the project' do
      proj = described_class.new
      e = 'jhonpeterson@mail.com'
      usr = User.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(proj.add_member(usr)).to be true
    end

    it 'Return false when existing member is being added to the project' do
      proj = described_class.new
      e = 'jhonpeterson@mail.com'
      vart = User.new(name: 'Jhon', last_name: 'Peterson', email: e)
      proj.add_member(vart)
      expect(proj.add_member(vart)).to be false
    end

    # it 'Should return false when invalid User object is passed' do
    #  proj = Projektas.new
    #  expect(proj.add_member(nil)).to be false
    # end
  end
end
