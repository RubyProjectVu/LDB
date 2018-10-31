# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/project'
require_relative '../lib/user'
require_relative '../lib/system'
require_relative '../lib/work_group'
require_relative '../lib/project_data_checker'
require 'yaml'

describe System do
  after do
    # Butina - kitaip mutant sumauna users.yml faila ir klasiu kintamuosius.
    hash = { 't@a.com' => { 'name' => 'tomas', 'lname' => 'genut',
                            'pwd' => '123' } }
    File.open('users.yml', 'w') { |fl| fl.write hash.to_yaml.gsub('---', '') }
  end

  it do
    expect(described_class.new.users_push('t@a.com', {})).to be false
  end

  it do
    described_class.new.users_pop('t@a.com')
    hsh = YAML.load_file('users.yml')
    expect(hsh.key?('t@a.com')).to be false
  end

  it do
    expect(described_class.new.users_pop('t@a.com')).to be true
  end

  it do
    expect(described_class.new.users_push('ask@ea.com',
                                          'ask@ea.com' => nil)).to be true
  end

  it 'returns true if all user input passes validation' do
    described_class.new.users_pop('t@a.com')
    expect(File.open('users.yml').grep(/---/)).to eq []
  end
end
