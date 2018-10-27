# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/project'
require_relative '../lib/user'

describe Project do
  let(:pr) { described_class.new }
  let(:usr) { User.new }

  context 'when project subscriber list manipulation' do
    it 'allows one member per name' do
      proj = described_class.new
      e = 'u1email@gmail.com'
      proj.add_subscriber('name lastname', e)
      expect(proj.add_subscriber('name lastname', e)).to be_falsey
    end

    it 'correctly finds current subscribers' do
      proj = described_class.new
      e = 'u1email@gmail.com'
      proj.add_subscriber('name lastname', e)
      proj.add_subscriber('josh lastname', e)
      expect(proj.notify_subscribers).to eq ['name lastname', 'josh lastname']
    end
  end

  it 'has its owner defined as the user after creation by default' do
    proj = described_class.new
    expect(proj.parm_manager).to eq Etc.getlogin
  end

  it do
    pr.set_deleted_status
    expect(pr.parm_project_status).to eq 'Deleted'
  end
end
