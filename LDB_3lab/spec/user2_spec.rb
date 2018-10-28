# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/user'

describe User do
  after do
    # Butina - kitaip mutant sumauna users.yml faila ir klasiu kintamuosius.
    hash = { 't@a.com' => { 'name' => 'tomas', 'lname' => 'genut',
                            'pwd' => '123' } }
    File.open('users.yml', 'w') { |fl| fl.write hash.to_yaml.gsub('---', '') }
  end

  it 'user1 should be equal to user1' do
    e = 't@a.com'
    v1 = described_class.new(email: e)
    expect(v1.register).to be false
  end

  it 'user1 should be 3qual to user1' do
    e = 'ee@a.com'
    v1 = described_class.new(name: 'tomas', last_name: 'genut', email: e)
    expect(v1.register).to be true
  end

  it do
    e = 't@a.com'
    v1 = described_class.new(email: e)
    expect(v1.delete_user).to be true
  end

  #it 'unregistered user should not be able to login' do
   # e = 't@t.com'
    # not existing user
    #described_class.new(name: 'no', last_name: 'user', email: e)
    #expect(System.new.login(e)).to be false
  #end
end
