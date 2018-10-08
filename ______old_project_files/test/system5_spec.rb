require 'simplecov'
SimpleCov.start

require_relative '../project'
require_relative '../user'
require_relative '../system'
require_relative '../work_group'
require_relative '../system_group_logger'
require_relative '../system_user_logger'
require_relative '../system_project_logger'
require_relative '../project_data_checker'
require_relative '../user_data_checker'

describe System do
  context 'when system should monitor user loggin in, out' do
    it 'logs a certificate upload' do
      # sys = described_class.new
      v1 = User.new(name: 'tomas', last_name: 'genut', email: 't@a.com')
      v1.unique_id_setter
      # fname = 'file.pdf'
      v1.upload_certificate('file.pdf')
      # sys.log_certificate_upload('tomas', 'genut', fname)
      str = 'User: tomas genut uploaded a certification file.pdf'
      expect(described_class.new.latest_entry).to start_with str
    end

    it 'The system should log a work group creation' do
      # sys = described_class.new
      v1 = User.new(name: 'tomas', last_name: 'genut', email: 't@a.com')
      v1.unique_id_setter
      v1.create_work_group('some name')
      # sys.log_work_group_creation(group.parm_work_group_name, v1)
      # s1 = 'Work group: some name created '
      # s2 = "by #{v1.unique_id_getter} at"
      expect(described_class.new.latest_entry).to start_with 'Work group: so' \
                                                             'me name created'
    end
  end
end
