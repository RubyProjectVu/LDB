# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/user'
require_relative '../lib/project'
require_relative '../lib/work_group'

describe User do
  let(:usr) { described_class.new }

  it do
    expect(usr.data_getter('name')).not_to be nil
  end

  it do
    expect(usr.data_getter('email')).not_to be nil
  end

  # TODO
  # it do
  #   expect(usr.prepare_deletion).to be true
  # end

  # TODO
  # it do
  #   usr.add_project('name', 'In progress')
  #   expect(usr.prepare_deletion).to be false
  # end

  # TODO
  # it do
  #   proj = usr.create_project('name', 'specific.txt')
  #   expect(proj.meta_getter).to eq 'specific.txt'
  # end

  # TODO
  # it do
  #   proj = usr.create_project('name', 'metadata.txt')
  #   usr.add_project(proj.parm_project_name, proj.parm_project_status)
  #   hash = usr.projects_getter
  #   expect(hash['name']).to eq 'Proposed'
  # end
end
