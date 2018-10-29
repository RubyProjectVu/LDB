# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/project'
require_relative '../lib/user'

describe Project do
  let(:pr) { described_class.new }
  let(:usr) { User.new }

  #it do
   # expect(pr.add_subscriber('name', 'mail')).not_to be_falsey
  #end

  it do
    expect(pr.set_deleted_status).to be true
  end

  it do
    expect(pr.add_member(usr)).to be true
  end

  #it do
   # expect(pr.meta_getter).to eq 'metadata.txt'
  #end

  it do
    # id is blank
    expect(pr.remove_member(usr)).to be false
  end

  it do
    usr = User.new(email: 'somemail')
    pr.add_member(usr)
    expect(pr.remove_member(usr)).to be true
  end
end
