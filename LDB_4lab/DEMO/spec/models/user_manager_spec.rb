# frozen_string_literal: true

#require 'simplecov'
#SimpleCov.start

#require_relative '../lib/user'
#require_relative '../lib/user_manager'
require_relative 'custom_matcher'
require_relative '../rails_helper'

describe UserManager do
  after do
    # Butina - kitaip mutant sumauna users.yml faila ir klasiu kintamuosius.
    #hash = { 't@a.com' => { 'name' => 'tomas', 'lname' => 'genut',
     #                       'pwd' => '123' } }
    #File.open('users.yml', 'w') { |fl| fl.write hash.to_yaml.gsub('---', '') }
  end

  it 'unregistered user should not be able to login' do
    e = 't@t.com'
    expect(described_class.new.login(e, 'pass')).to be false
  end

  it 'registered user should be able to login' do
    e = 't@a.com'
    expect(described_class.new.login(e, '123')).to be true
  end

  it 'existing user cannot register again' do
    e = 't@a.com'
    v1 = described_class.new
    expect(v1.register('', '', e, '')).to be false
  end

  it 'deleting existing user' do
    e = 't@a.com'
    v1 = described_class.new
    expect(v1.delete_user(e)).to be true
  end

  it 'deleting non-existing user' do
    e = 'no@no.com'
    v1 = described_class.new
    expect(v1.delete_user(e)).to be false
  end

  # TODO: active project checking will be implemented later
end
