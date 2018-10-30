# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/user'
require_relative '../lib/user_manager'
require_relative '../lib/work_group'

describe User do
  let(:usr) { described_class.new }

  it do
    expect(usr.data_getter('name')).not_to be nil
  end

  it do
    expect(usr.data_getter('email')).not_to be nil
  end

  it do
    usr = described_class.new(name: 'n', last_name: 'l', email: 'mail')
    expect(usr.to_hash).to eq 'mail' => {'name' => 'n', 'lname' => 'l', 'pwd' => '123'}
  end

  it do
    expect(UserManager.new.to_hash('t@a.com')).to eq 't@a.com' => { 'name' => 'tomas', 'lname' => 'genut', 'pwd' => '123' }
  end
end
