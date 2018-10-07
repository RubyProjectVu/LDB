require 'simplecov'
SimpleCov.start

require_relative '../User'
require_relative '../system'
require_relative '../system_user_logger'
require_relative '../system_group_logger'
require_relative '../system_project_logger'

describe User do
  let(:sys) { System.new }

  it 'when a user should not be able to login if it has already done that' do
    sys1 = System.new
    # existing user
    v1 = described_class.new(name: 'tomas', last_name: 'genut',
                             email: 't@a.com')
    v1.unique_id_setter('48c7dcc645d82e57f049bd414daa5ae2')
    # expect(sys.login(v1)).to be true
    # sys.login(v1)
    expect(sys1.login(v1) && sys1.login(v1)).to be false
  end

  context 'when a user tries to logout' do
    it 'logs out if user exists' do
      # existing user
      e = 't@a.com'
      v1 = described_class.new(name: 'tomas', last_name: 'genut', email: e)
      v1.unique_id_setter('48c7dcc645d82e57f049bd414daa5ae2')

      # sys = System.new
      # expect(sys.login(v1)).to be true
      sys.login(v1)
      expect(sys.logout(v1)).to equal v1
    end

    it 'returns nil on error' do
      # existing user
      e = 't@a.com'
      v1 = described_class.new(name: 'tomas', last_name: 'genut', email: e)
      v1.unique_id_setter('48c7dcc645d82e57f049bd414daa5ae2')
      expect(System.new.logout(v1)).to be nil
    end
  end
end
