require 'simplecov'
SimpleCov.start

require_relative '../project_merger'
require_relative '../project'

describe ProjectMerger do
  it 'do not continue notifying when a file is missing' do
    pm = described_class.new
    expect(pm.notify_managers('nofile.txt', 'nofile2.txt')).to be false
  end

  # it 'returns empty string otherwise' do
  #  pm = described_class.new
  #  Project.new
  #  expect(pm.get_manager_from_meta('metadata.txt')).to eq ''
  # end

  it 'notifies managers of both projects' do
    pm = described_class.new
    # Project.new
    # Project.new(meta_filename: 'metadata2.txt')
    # fileone = File.open('metadata.txt', 'w')
    # filetwo = File.open('metadata2.txt', 'w')
    File.write('metadata.txt', 'manager: somename')
    File.write('metadata2.txt', 'manager: othername')
    # set managers to both
    # fileone.puts('manager: somename')
    # filetwo.puts('manager: othername')
    # fileone.close
    # filetwo.close
    # words = %w[somename othername]
    expect(pm.notify_managers('metadata.txt',
                              'metadata2.txt')).to eql %w[somename othername]
  end

  it 'do not be able to merge into self' do
    pm = described_class.new
    Project.new
    File.write('metadata.txt', 'projid: 1')
    # fileone = File.open('metadata.txt', 'w')
    # fileone.puts('projid: 1')
    # fileone.close
    expect(pm.prepare_merge('metadata.txt', 'metadata.txt')).to be false
  end
end
