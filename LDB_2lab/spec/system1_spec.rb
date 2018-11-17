# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/project'
require_relative '../lib/user'
require_relative '../lib/system'
require_relative '../lib/work_group'
require_relative '../lib/project_data_checker'

describe System do
  after do
    # Butina - kitaip mutant sumauna users.yml faila ir klasiu kintamuosius.
    hash = { 't@a.com' => { 'name' => 'tomas', 'lname' => 'genut',
                            'pwd' => '123' } }
    File.open('users.yml', 'w') { |fl| fl.write hash.to_yaml.gsub('---', '') }
  end

  it do
    sys = described_class.new
    expect(sys.login('t@a.com')).not_to be_nil
  end

  it do
    sys = described_class.new
    expect(sys.last_use('time')).not_to be false
  end

  it do
    sys = described_class.new
    expect(sys.last_use('time')).to eq 'sometime'
  end

  it do
    sys = described_class.new
    expect(sys.last_use('nonkey')).to be false
  end
end
