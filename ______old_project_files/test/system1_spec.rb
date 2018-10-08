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
  it 'The system should log a work group deletion' do
    # sys = described_class.new
    # group = WorkGroup.new
    User.new(name: 'tomas', last_name: 'genut', email: 't@a.com')
        .unique_id_setter
    # v1.unique_id_setter
    # sys.log_work_group_deletion(group.parm_work_group_name, v1)
    # s1 = "Work group: #{group.parm_work_group_name} deleted "
    # s2 = "by #{v1.unique_id_getter} at"
    WorkGroup.new.deleted_status_setter('someid')
    expect(described_class.new.latest_entry).to include 'Work group'
  end

  it 'The system should log a user login' do
    # sys = described_class.new
    usr = User.new(name: 'tomas', last_name: 'genut', email: 't@a.com')
    usr.unique_id_setter('48c7dcc645d82e57f049bd414daa5ae2')
    described_class.new.login(usr)
    # sys.log_user_login_logout('tomas', 'genut')
    expect(described_class.new.latest_entry).to start_with 'User: ["tomas", "g'
    # expect(sys.latest_entry).to include('logs in at')
    # sys.logout(usr)
    # sys.log_user_login_logout('tomas', 'genut', false)
    # expect(sys.latest_entry).to start_with 'User: ["tomas", "genut"] '
    # expect(sys.latest_entry).to include('logs out at')
  end

  it 'The system should log a user logout' do
    # sys = described_class.new
    usr = User.new(name: 'tomas', last_name: 'genut', email: 't@a.com')
    usr.unique_id_setter('48c7dcc645d82e57f049bd414daa5ae2')
    described_class.new.login(usr)
    # sys.log_user_login_logout('tomas', 'genut')
    # expect(sys.latest_entry).to start_with 'User: ["tomas", "genut"] '
    # expect(sys.latest_entry).to include('logs in at')
    described_class.new.logout(usr)
    # sys.log_user_login_logout('tomas', 'genut', false)
    expect(described_class.new.latest_entry).to start_with 'User: ["tomas",'
    # expect(sys.latest_entry).to include('logs out at')
  end

  it 'The system should log a project creation' do
    # sys = described_class.new
    # e = 't@a.com'
    usr = User.new(name: 'tomas', last_name: 'genut', email: 't@a.com')
    # usr.unique_id_setter
    proj = usr.create_project('some name', 'some_meta.txt')
    # sys.log_project_creation(proj.parm_project_name, usr)
    s1 = "Project: #{proj.parm_project_name} created "
    # s2 = "by #{usr.unique_id_getter} at"
    expect(described_class.new.latest_entry).to start_with s1
  end
end
