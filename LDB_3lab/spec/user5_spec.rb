# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/user'

describe User do
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

  # it 'project status is set correctly' do
  #  expect(usr.add_project('name', 'In progress')).to eq 'In progress'
  # end

  # it '' do
  #   usr.add_project('name', 'In progress')
  #   expect(usr.active_projects_present?).to be true
  # end

  it do
    expect(usr2.data_getter('email')).to eq ''
  end

  it do
    expect(usr2.data_getter('pass')).to eq '123'
  end
end
