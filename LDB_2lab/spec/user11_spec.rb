# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/user'
require_relative '../lib/system'

describe User do
  let(:usr) do
    described_class.new(name: 'name',
                        last_name: 'lname',
                        email: 'email')
  end
  let(:usr2) { described_class.new }

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
end
