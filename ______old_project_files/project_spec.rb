require 'simplecov'
SimpleCov.start

require_relative 'projektas'
require_relative 'vartotojas'

describe Projektas do
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

  it 'is be able to remove itself if there are no active projects' do
    proj = described_class.new(project_name: 'Name')
    proj.parm_project_status('Postponed')
    usr = Vartotojas.new
    usr.add_project(proj.parm_project_name, proj.parm_project_status)
    expect(usr.prepare_deletion).to be true
    # proj.parm_project_status('Postponed')
    # usr.change_project_status(proj.parm_project_name, 'Postponed')
    # expect(usr.prepare_deletion).to be true
  end
end