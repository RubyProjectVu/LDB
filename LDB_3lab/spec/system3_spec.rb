# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/project'
require_relative '../lib/user'
require_relative '../lib/work_group'

describe Project do
  context 'when a user tries to remove its account' do
    it 'is not able to remove itself if there are active projects' do
      pr = described_class.new(project_name: 'Name')
      pr.parm_project_status('In progress')
      usr = User.new
      usr.add_project(pr.parm_project_name, pr.parm_project_status)
      expect(usr.prepare_deletion).to be false
    end
  end
end
