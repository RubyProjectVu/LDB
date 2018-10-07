require 'simplecov'
SimpleCov.start

require_relative '../project'
require_relative '../User'

describe Project do
  it 'do not set an undefined status' do
    proj = described_class.new
    # expect(proj.parm_project_status).to be nil
    str1 = 'Please set status as one of: '
    str2 = ['Proposed', 'Suspended', 'Postponed',
            'Cancelled', 'In progress'].join(', ')
    expect(proj.parm_project_status('ddd')).to eq str1 + str2
    # proj.parm_project_status('Proposed')
    # expect(proj.project_status).to eq 'Proposed'
  end

  context 'when project is validating its metadata, status, owner' do
    it 'is able to find/open the metadata file created after init' do
      proj = described_class.new
      expect(proj.check_metadata).to be true
    end

    it 'has its owner set correctly' do
      proj = described_class.new
      # expect(proj.parm_manager).to eq Etc.getlogin
      proj.parm_manager('some name')
      expect(proj.parm_manager).to eq 'some name'
    end

    it 'sets/returns valid status' do
      proj = described_class.new
      # expect(proj.parm_project_status).to be nil
      # str1 = 'Please set status as one of: '
      # str2 = ['Proposed', 'Suspended', 'Postponed',
      #        'Cancelled', 'In progress'].join(', ')
      # expect(proj.parm_project_status('ddd')).to eq str1 + str2
      proj.parm_project_status('Proposed')
      expect(proj.project_status).to eq 'Proposed'
    end
  end
end
