# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/user'
require_relative '../lib/user_manager'

describe User do
  after do
    # Butina - kitaip mutant sumauna users.yml faila ir klasiu kintamuosius.
    hash = { 't@a.com' => { 'name' => 'tomas', 'lname' => 'genut',
                            'pwd' => '123' } }
    File.open('users.yml', 'w') { |fl| fl.write hash.to_yaml.gsub('---', '') }
  end

  it 'name is actually written when registering' do
    UserManager.new.register(described_class.new(name: 'neim',
                                                 email: 'de@mo.com'))
    hash = YAML.load_file('users.yml')
    expect(hash['de@mo.com']['name']).to eq 'neim'
  end

  it 'l name is actually written when registering' do
    UserManager.new.register(described_class.new(last_name: 'lastname',
                                                 email: 'de@mo.com'))
    hash = YAML.load_file('users.yml')
    expect(hash['de@mo.com']['lname']).to eq 'lastname'
  end
end
