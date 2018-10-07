require 'simplecov'
SimpleCov.start

require_relative '../User'
require_relative '../system'
require_relative '../system_user_logger'
require_relative '../system_group_logger'
require_relative '../system_project_logger'

describe User do
  context 'when a user tries to login' do
    it 'user1 should be equal to user1' do
      e = 'email@email.com'
      v1 = described_class.new(name: 'name', last_name: 'lastname', email: e)
      v1.unique_id_setter('123456789')
      expect(v1.equals(v1)).to be true
    end

    it 'registered user should be able to login' do
      sys = System.new
      e = 't@a.com'
      # existing user
      v1 = described_class.new(name: 'tomas', last_name: 'genut', email: e)
      v1.unique_id_setter('48c7dcc645d82e57f049bd414daa5ae2')
      expect(sys.login(v1)).to be true
    end

    it 'unregistered user should not be able to login' do
      sys = System.new
      e = 't@a.com'
      # not existing user
      v1 = described_class.new(name: 'no', last_name: 'user', email: e)
      v1.unique_id_setter('40c0dcc000d00e57f000bd000daa0ae0')
      expect(sys.login(v1)).to be false
    end
  end
end
