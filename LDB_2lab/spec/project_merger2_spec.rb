# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/project_merger'
require_relative '../lib/project'

describe ProjectMerger do
  it 'notifies managers of both projects1' do
    pm = described_class.new
    expect(pm.notify_managers('metadata.txt',
                              'nofile.txt')).to be false
  end

  it 'notifies managers of both projects2' do
    pm = described_class.new
    expect(pm.notify_managers('nofile.txt',
                              'metadata.txt')).to be false
  end

  it 'notifies managers of both projects3' do
    pm = described_class.new
    File.write('metadata.txt', 'manager: somename')
    File.write('metadata2.txt', 'manager: othername')
    expect(pm.notify_managers('metadata.txt',
                              'metadata2.txt')).to eql %w[somename othername]
  end

  it 'do not be able to merge into self' do
    pm = described_class.new
    Project.new
    File.write('metadata.txt', 'projid: 1')
    expect(pm.prepare_merge('metadata.txt', 'metadata.txt')).to be false
  end
end
