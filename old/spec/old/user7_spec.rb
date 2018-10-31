# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/user'
require_relative '../lib/system'

describe User do
  after do
    # Butina - kitaip mutant sumauna users.yml faila ir klasiu kintamuosius.
    hash = { 't@a.com' => { 'name' => 'tomas', 'lname' => 'genut',
                            'pwd' => '123' } }
    File.open('users.yml', 'w') { |fl| fl.write hash.to_yaml.gsub('---', '') }
  end

  it 'user is actually deleted in file' do
    described_class.new(email: 't@a.com').delete_user
    hash = YAML.load_file('users.yml')
    expect(hash.key?('t@a.com')).to be false
  end

  it 'pass is actually written when registering' do
    described_class.new(email: 'de@mo.com').register
    hash = YAML.load_file('users.yml')
    expect(hash['de@mo.com']['pwd']).to eq '123'
  end

  it 'returns true if new work group was created' do
    e = 'jhonpeterson@mail.com'
    vart = described_class.new(name: 'Jhon', last_name: 'Peterson', email: e)
    expect(vart.create_work_group('Marketing')).to be_truthy
  end

  it 'email is actually written when registering' do
    described_class.new(email: 'de@mo.com').register
    hash = YAML.load_file('users.yml')
    expect(hash.key?('de@mo.com')).to be true
  end
end
