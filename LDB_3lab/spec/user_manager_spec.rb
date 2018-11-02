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

  it 'unregistered user should not be able to login' do
    e = 't@t.com'
    expect(described_class.new.login(e)).to be false
  end

  it 'user is actually deleted in file' do
    described_class.new.delete_user(User.new(email: 't@a.com'))
    hash = YAML.load_file('users.yml')
    expect(hash).to be false # empty file
  end

  it 'pass is actually written when registering' do
    described_class.new.register(User.new(email: 'de@mo.com'))
    hash = YAML.load_file('users.yml')
    expect(hash['de@mo.com']['pwd']).to eq '123'
  end

  it 'email is actually written when registering' do
    described_class.new.register(User.new(email: 'de@mo.com'))
    hash = YAML.load_file('users.yml')
    expect(hash.key?('de@mo.com')).to be true
  end

  it 'name is actually written when registering' do
    described_class.new.register(User.new(name: 'neim',
                                          email: 'de@mo.com'))
    hash = YAML.load_file('users.yml')
    expect(hash['de@mo.com']['name']).to eq 'neim'
  end

  it 'l name is actually written when registering' do
    described_class.new.register(User.new(last_name: 'lastname',
                                          email: 'de@mo.com'))
    hash = YAML.load_file('users.yml')
    expect(hash['de@mo.com']['lname']).to eq 'lastname'
  end

  it 'file is cleared of three dashes' do
    user = User.new(name: 'tomas', last_name: 'genut', email: 't@a.com')
    described_class.new.delete_user(user)
    expect(File.read('users.yml').match?(/---/)).to be false
  end

  it 'registered user should be able to login' do
    e = 't@a.com'
    expect(described_class.new.login(e)).to be true
  end

  it 'initial current user is a nil hash' do
    hsh = {}
    expect(described_class.new.current_user_getter).to eq hsh
    # rubocop supposes to switch to {} - which fails
  end

  it 'user1 should be equal to user' do
    e = 't@a.com'
    v1 = described_class.new
    expect(v1.register(User.new(email: e))).to be false
  end

  it 'user1 should be equal to user1' do
    e = 'ee@a.com'
    user = User.new(name: 'tomas', last_name: 'genut', email: e)
    v1 = described_class.new
    expect(v1.register(user)).to be true
  end

  it 'deleting existing user' do
    e = 't@a.com'
    v1 = described_class.new
    expect(v1.delete_user(User.new(email: e))).to be true
  end

  it 'preparing for deletion is a go - always' do
    # TODO: active project checking will be implemented later
    expect(described_class.new.prepare_deletion).to be true
  end

  it 'three dashes are cleared' do
    e = 'ee@a.com'
    user = User.new(name: 'tomas', last_name: 'genut', email: e)
    described_class.new.register(user)
    expect(File.read('users.yml').match?(/---/)).to be false
  end
end
