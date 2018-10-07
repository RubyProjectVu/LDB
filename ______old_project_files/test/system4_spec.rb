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
  it 'The system should log a user logout' do
    sys = described_class.new
    usr = User.new(name: 'tomas', last_name: 'genut', email: 't@a.com')
    sys.login(usr)
    # sys.log_user_login_logout('tomas', 'genut')
    sys.logout(usr)
    # sys.log_user_login_logout('tomas', 'genut', false)
    expect(sys.latest_entry).to start_with 'User: ["tomas", "genut"] '
    # expect(sys.latest_entry).to include('logs out at')
  end

  it 'The system should log a request and see the email and user' do
    # sys = described_class.new
    e = 'emailname@gmail.com'
    usr = User.new(name: 'some name', last_name: 'pavardenis', email: e)
    usr.resend_password_link
    # e = 'emailname@gmail.com'
    # sys.log_password_request('some name', 'pavardenis', e)
    # s1 = 'Password request for user:'
    expect(described_class.new.latest_entry).to start_with 'Password ' \
                                                           'request for user:'
  end
end
