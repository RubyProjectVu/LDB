# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/project'
require_relative '../lib/user'

describe Project do
  let(:pr) { described_class.new }
  let(:usr) { User.new }

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
end
