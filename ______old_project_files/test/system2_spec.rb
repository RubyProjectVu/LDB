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
  context 'when a user tries to register' do
    it 'returns false if user with that email already exists' do
      udc = UserDataChecker.new
      usr1 = User.new(name: 'tomas', last_name: 'genut', email: 't@a.com')
      expect(udc.register(usr1)).to be false
    end

    it 'returns false if users email wont match email template' do
      # sys = described_class.new
      # usr1=User.new(name: 'qwert', last_name: 'setas', email: 'ga23am')
      usr2 = User.new(name: 'genut', last_name: 'tomas', email: 'g@am')
      # expect(usr1.user_input_validation).to be false
      expect(usr2.user_input_validation).to be false
    end

    it 'returns true if user successfully registered' do
      udc = UserDataChecker.new
      # sys = System.new
      usr1 = User.new(name: 'jonas', last_name: 'jon', email: 'j@j.com')
      # expect(usr1.user_input_validation).to be true
      expect(udc.register(usr1)).to be true
    end
  end

  it 'returns true if all user input passes validation' do
    # sys = described_class.new
    usr1 = User.new(name: 'jonas', last_name: 'jon', email: 'j@j.com')
    expect(usr1.user_input_validation).to be true
  end
end
