# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/project_merger'
require_relative '../lib/project'

describe ProjectMerger do
  it 'have no issues with different ids' do
    pm = described_class.new
    File.write('metadata.txt', 'projid: 1')
    File.write('metadata2.txt', 'projid: 2')
    expect(pm.prepare_merge('metadata.txt', 'metadata2.txt')).to be true
  end

  it 'do not continue merging when a file3 is missing' do
    pm = described_class.new
    expect(pm.prepare_merge('nofile.txt', 'nofile2.txt')).to be false
  end

  it 'do not continue merging when a file1 is missing' do
    pm = described_class.new
    expect(pm.prepare_merge('nofile.txt', 'metadata.txt')).to be false
  end

  it 'do not continue merging when a file2 is missing' do
    pm = described_class.new
    expect(pm.prepare_merge('metadata.txt', 'nofile.txt')).to be false
  end

  it 'do not continue notifying when a file is missing' do
    pm = described_class.new
    expect(pm.notify_managers('nofile.txt', 'nofile2.txt')).to be false
  end
end
