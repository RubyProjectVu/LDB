# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/user'
require_relative '../lib/system'

describe User do
  after do
    # Butina - kitaip mutant sumauna users.yml faila ir klasiu kintamuosius.
    hash = { 't@a.com' => { 'name' => 'tomas', 'lname' => 'genut',
                            'pwd' => '123' } }
    File.open('users.yml', 'w') { |fl| fl.write hash.to_yaml.gsub('---', '') }
  end

  context 'when User creates a new project' do
    it 'returns true when a new project is created' do
      e = 'jhonpeterson@mail.com'
      vart = described_class.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(vart.create_project('Project', 'rojec.txt')).to be_truthy
    end
  end

  it 'name is actually written when registering' do
    described_class.new(name: 'neim', email: 'de@mo.com').register
    hash = YAML.load_file('users.yml')
    expect(hash['de@mo.com']['name']).to eq 'neim'
  end

  it 'l name is actually written when registering' do
    described_class.new(last_name: 'lastname',
                        email: 'de@mo.com').register
    hash = YAML.load_file('users.yml')
    expect(hash['de@mo.com']['lname']).to eq 'lastname'
  end
end
