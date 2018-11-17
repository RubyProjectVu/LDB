# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/project'
require_relative '../lib/user'
require_relative '../lib/system'
require_relative '../lib/work_group'
require_relative '../lib/project_data_checker'

describe System do
  after do
    # Butina - kitaip mutant sumauna users.yml faila ir klasiu kintamuosius.
    hash = { 't@a.com' => { 'name' => 'tomas', 'lname' => 'genut',
                            'pwd' => '123' } }
    File.open('users.yml', 'w') { |fl| fl.write hash.to_yaml.gsub('---', '') }
  end

  it 'new user actually saved' do
    described_class.new.users_push('ea@ea.com', 'ea@ea.com' => nil)
    hsh = YAML.load_file('users.yml')
    expect(hsh.key?('ea@ea.com')).to be true
  end

  it 'unsuccessful login with unregistered user' do
    sys = described_class.new
    expect(sys.login('t@t.com')).to be false
  end

  it 'successful login with registered user' do
    sys = described_class.new
    expect(sys.login('t@a.com')).to be true
  end
end
