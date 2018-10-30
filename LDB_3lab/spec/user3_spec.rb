# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/user'

describe User do
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
