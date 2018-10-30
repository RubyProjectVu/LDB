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

  it do
    expect(described_class.new.current_user).to eq Hash.new
    # rubocop supposes to switch to {} - which fails
  end

  it do
    # TODO: active project checking will be implemented later
    expect(described_class.new.prepare_deletion).to be true
  end
end
