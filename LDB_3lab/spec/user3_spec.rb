# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/user'

describe User do
  context 'when a user deletes a work group' do
    it 'returns true when work group is deleted' do
      group = WorkGroup.new
      e = 'jhonpeterson@mail.com'
      described_class.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(group.deleted_status_setter).to be true
    end

    it 'returns false when work group is already deleted' do
      group = WorkGroup.new
      e = 'jhonpeterson@mail.com'
      described_class.new(name: 'Jhon', last_name: 'Peterson', email: e)
      group.deleted_status_setter
      expect(group.deleted_status_setter).to be false
    end
  end

  context 'when User deletes a project' do
    it 'returns true when project is deleted' do
      expect(Project.new.set_deleted_status).to be true
    end

    it 'returns false when project is already deleted' do
      proj = Project.new
      proj.set_deleted_status
      expect(proj.set_deleted_status).to be false
    end
  end
end
