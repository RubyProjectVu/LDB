# frozen_string_literal: true

#require 'simplecov'
#SimpleCov.start

#require_relative '../lib/user'
#require_relative '../lib/user_manager'
#require_relative 'custom_matcher'
require_relative '../rails_helper'

describe User do
  after do
    # Butina - kitaip mutant sumauna users.yml faila ir klasiu kintamuosius.
    hash = { 't@a.com' => { 'name' => 'tomas', 'lname' => 'genut',
                            'pwd' => '123' } }
    File.open('users.yml', 'w') { |fl| fl.write hash.to_yaml.gsub('---', '') }
  end

  let(:usr) do
    described_class.new(name: 'name',
                        last_name: 'lname',
                        email: 'email')
  end

  let(:usr2) { described_class.new }

  it 'password is set correctly' do
    usr.password_set('password')
    expect(usr.data_getter('pass')).to eq 'password'
  end

  it 'unset email is empty' do
    expect(usr2.data_getter('email')).to eq ''
  end

  it 'default pass is very secure' do
    expect(usr2.data_getter('pass')).to eq '123'
  end

  context 'when User deletes a project' do
    it 'returns true when project is deleted' do
      expect(Project.new.set_deleted_status).to be true
    end

    it 'returns false when project is already deleted' do
      proj = Project.new
      proj.set_deleted_status
      expect(proj.set_deleted_status).to be false
    end
  end

  it 'sets the name correctly' do
    expect(usr.data_getter('name')).to eq 'name'
  end

  it 'sets the last name correctly' do
    expect(usr.data_getter('lname')).to eq 'lname'
  end

  it 'sets the email correctly' do
    expect(usr.data_getter('email')).to eq 'email'
  end

  it 'sets the pass correctly' do
    expect(usr.data_getter('pass')).to eq '123'
  end

  it 'name is initially empty' do
    expect(usr2.data_getter('name')).to eq ''
  end

  it 'last name is initially empt' do
    expect(usr2.data_getter('lname')).to eq ''
  end

  it 'name is never nil' do
    expect(usr.data_getter('name')).not_to be nil
  end

  it 'email is never nil' do
    expect(usr.data_getter('email')).not_to be nil
  end

  it 'user gets converted to hash correctly' do
    usr = described_class.new(name: 'n', last_name: 'l', email: 'mail')
    expect(usr.to_hash).to eq 'mail' => { 'name' => 'n', 'lname' => 'l',
                                          'pwd' => '123' }
  end

  it 'conversion by id/email is correct' do
    expect(UserManager.new.to_hash('t@a.com')).to eq 't@a.com' => {
      'name' => 'tomas', 'lname' => 'genut', 'pwd' => '123'
    }
  end

  it 'password is indeed advanced' do
    pass = '*as-w0rd'
    expect(pass).to has_advanced_password
  end

  it 'fails because no special characters included' do
    pass = '1simple'
    expect(pass).not_to has_advanced_password
  end

  it 'userinfo is correct' do
    expect(usr.user_info).to eq 'name'.to_sym => 'name',
                                'lname'.to_sym => 'lname',
                                'email'.to_sym => 'email',
                                'pass'.to_sym => '123'
  end
end
