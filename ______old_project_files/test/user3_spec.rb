require 'simplecov'
SimpleCov.start

require_relative '../user'
require_relative '../system'
require_relative '../system_user_logger'
require_relative '../system_group_logger'
require_relative '../system_project_logger'

describe User do
  context 'when a user deletes a work group' do
    # it 'returns false when nil is being passed to delete_work_group' do
    #  e = 'jhonpeterson@mail.com'
    #  vart = described_class.new(name: 'Jhon', last_name: 'Peterson', email: e)
    #  expect(vart.delete_work_group(nil)).to be false
    # end

    it 'returns true when work group is deleted' do
      group = WorkGroup.new
      e = 'jhonpeterson@mail.com'
      vart = described_class.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(group.deleted_status_setter(vart.unique_id_getter)).to be true
    end

    it 'returns false when work group is already deleted' do
      group = WorkGroup.new
      e = 'jhonpeterson@mail.com'
      vart = described_class.new(name: 'Jhon', last_name: 'Peterson', email: e)
      group.deleted_status_setter(vart.unique_id_getter)
      expect(group.deleted_status_setter(vart.unique_id_getter)).to be false
    end
  end

  context 'when User deletes a project' do
    # it 'returns false when nil is being passed to delete_project' do
    #  e = 'jhonpeterson@mail.com'
    #  vart = described_class.new(name: 'Jhon', last_name: 'Peterson', email: e)
    #  expect(vart.delete_project(nil)).to be false
    # end

    it 'returns true when project is deleted' do
      # proj = Project.new
      # e = 'jhonpeterson@mail.com'
      # vart = described_class.new(name: 'Jhon', last_name: 'Peterson',
      #                             email: e)
      expect(Project.new.set_deleted_status).to be true
    end

    it 'returns false when project is already deleted' do
      proj = Project.new
      # e = 'jhonpeterson@mail.com'
      # vart = described_class.new(name: 'Jhon', last_name: 'Peterson',
      #                             email: e)
      proj.set_deleted_status
      expect(proj.set_deleted_status).to be false
    end
  end
end
