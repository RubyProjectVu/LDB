# frozen_string_literal: true

#require 'simplecov'
#SimpleCov.start

#require_relative '../lib/user'
#require_relative '../lib/user_manager'
require_relative 'custom_matcher'
require_relative '../rails_helper'

describe User do
  after do
    # Butina - kitaip mutant sumauna users.yml faila ir klasiu kintamuosius.
    # hash = { 't@a.com' => { 'name' => 'tomas', 'lname' => 'genut',
      #                      'pwd' => '123' } }
    # File.open('users.yml', 'w') { |fl| fl.write hash.to_yaml.gsub('---', '') }
  end

  let(:usr) do
    described_class.create(name: 'name',
                        lname: 'lname',
                        email: 'email',
                        pass: 'pass')
  end

  # let(:usr2) { described_class.new }

  it 'password is set correctly' do
    described_class.create(name: 'name', lname: 'lname', email: 'email', pass: 'pass')
    usr = User.find_by(name: 'name')
    usr.password_set('password')
    expect(User.find_by(name: 'name').pass).to eq 'password'
  end

  it 'sets the last name correctly' do
    described_class.create(name: 'name', lname: 'lname', email: 'email', pass: 'pass')
    usr = User.find_by(name: 'name')
    expect(User.find_by(name: 'name').lname).to eq 'lname'
  end

  it 'sets the email correctly' do
    described_class.create(name: 'name', lname: 'lname', email: 'email', pass: 'pass')
    usr = User.find_by(name: 'name')
    expect(User.find_by(name: 'name').email).to eq 'email'
  end

  it 'sets the pass correctly' do
    described_class.create(name: 'name', lname: 'lname', email: 'email', pass: 'pass')
    usr = User.find_by(name: 'name')
    expect(User.find_by(name: 'name').pass).to eq 'pass'
  end

  it 'password is indeed advanced' do
    pass = '*as-w0rd'
    expect(pass).to has_advanced_password
  end

  it 'fails because no special characters included' do
    pass = '1simple'
    expect(pass).not_to has_advanced_password
  end
end
