# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/user'
require_relative '../lib/user_manager'

describe UserManager do
  after do
    # Butina - kitaip mutant sumauna users.yml faila ir klasiu kintamuosius.
    hash = { 't@a.com' => { 'name' => 'tomas', 'lname' => 'genut',
                            'pwd' => '123' } }
    File.open('users.yml', 'w') { |fl| fl.write hash.to_yaml.gsub('---', '') }
  end

  it do
    e = 'ee@a.com'
	user = User.new(name: 'tomas', last_name: 'genut', email: e)
    described_class.new.register(user)
    expect(File.read('users.yml').match?(/---/)).to be false
  end

  it do
    user = User.new(name: 'tomas', last_name: 'genut', email: 't@a.com')
    described_class.new.delete_user(user)
    expect(File.read('users.yml').match?(/---/)).to be false
  end

  #it 'registered user should be able to login' do
   # sys = System.new
    #e = 't@a.com'
    # existing user
    #described_class.new(name: 'tomas', last_name: 'genut', email: e)
    #expect(sys.login(e)).to be true
  #end
end
