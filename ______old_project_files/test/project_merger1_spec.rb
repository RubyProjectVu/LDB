require 'simplecov'
SimpleCov.start

require_relative '../project_merger'
require_relative '../project'

describe ProjectMerger do
  it 'have no issues with different ids' do
    pm = described_class.new
    # Project.new
    # Project.new(meta_filename: 'metadata2.txt')
    # write ids to both
    File.write('metadata.txt', 'projid: 1')
    File.write('metadata2.txt', 'projid: 2')
    # fileone.puts('projid: 1')
    # filetwo.puts('projid: 2')
    # fileone.close
    # filetwo.close
    expect(pm.prepare_merge('metadata.txt', 'metadata2.txt')).to be true
  end

  it 'do not continue merging when a file is missing' do
    pm = described_class.new
    expect(pm.prepare_merge('nofile.txt', 'nofile2.txt')).to be false
  end

  it 'finds the manager in metafile' do
    # pm = described_class.new
    pdc = ProjectDataChecker.new('metadata.txt')
    Project.new
    # write manager
    File.write('metadata.txt', 'manager: somename')
    # fileone = File.open('metadata.txt', 'w')
    # fileone.puts('manager: somename')
    # fileone.close
    # expect(pm.get_manager_from_meta('metadata.txt')).to eq 'somename'
    expect(pdc.manager_from_meta_getter).to eq 'somename'
  end
end
