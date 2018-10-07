require 'simplecov'
SimpleCov.start

require_relative '../project'
require_relative '../User'
require_relative '../system'
require_relative '../work_group'
require_relative '../system_group_logger'
require_relative '../system_user_logger'
require_relative '../system_project_logger'
require_relative '../project_data_checker'
require_relative '../user_data_checker'

describe System do
  context 'when a user tries to remove its account' do
    it 'is not able to remove itself if there are active projects' do
      pr = Project.new(project_name: 'Name')
      pr.parm_project_status('In progress')
      # proj.parm_project_status('In progress')
      usr = User.new
      usr.add_project(pr.parm_project_name, pr.parm_project_status)
      expect(usr.prepare_deletion).to be false
      # proj.parm_project_status('Postponed')
      # usr.change_project_status(proj.parm_project_name, 'Postponed')
      # expect(usr.prepare_deletion).to be true
    end
  end

  context 'when performing action with project files' do
    it 'returns false on non existant file deletion' do
      # Project.new
      pdc = ProjectDataChecker.new('metadata.txt')
      expect(pdc.delete_file('filename.txt')).to be false
    end

    it 'returns true on existing file deletion' do
      # Project.new
      pdc = ProjectDataChecker.new('metadata.txt')
      expect(pdc.delete_file('file_to_delete.txt')).to be true
    end

    it 'returns true on file creation' do
      # Project.new
      pdc = ProjectDataChecker.new('metadata.txt')
      expect(pdc.create_file('created_file.txt')).to be true
    end
  end
end
