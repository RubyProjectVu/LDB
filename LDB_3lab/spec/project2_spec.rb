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
end
