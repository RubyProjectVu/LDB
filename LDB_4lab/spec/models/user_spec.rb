# frozen_string_literal: true

require_relative 'custom_matcher'
require_relative '../rails_helper'

describe User do
  fixtures :all

  let(:usr) do
    described_class.create(name: 'name',
                           lname: 'lname',
                           email: 'email',
                           pass: 'pass')
  end

  let(:usrstub) do
    usrstub = double
    allow(usrstub).to receive(:find_first).and_return(described_class.first)
    allow(usrstub).to receive(:password_set)
    allow(usrstub).to receive(:pass_secure)
    usrstub
  end

  it 'always checks whether password is secure' do
    expect(usrstub.find_first).to receive(:pass_secure)
    usrstub.find_first.password_set('string')
  end

  it 'password is set correctly' do
    described_class.create(name: 'name', lname: 'lname', email: 'email',
                           pass: 'pass')
    usr = described_class.find_by(name: 'name')
    usr.password_set('password')
    expect(described_class.find_by(name: 'name').pass).to eq 'pass'
  end

  it 'sets the last name correctly' do
    described_class.create(name: 'name', lname: 'lname', email: 'email',
                           pass: 'pass')
    expect(described_class.find_by(name: 'name').lname).to eq 'lname'
  end

  it 'sets the email correctly' do
    described_class.create(name: 'name', lname: 'lname', email: 'email',
                           pass: 'pass')
    expect(described_class.find_by(name: 'name').email).to eq 'email'
  end

  it 'sets the pass correctly' do
    described_class.create(name: 'name', lname: 'lname', email: 'email',
                           pass: 'pass')
    expect(described_class.find_by(name: 'name').pass).to eq 'pass'
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
