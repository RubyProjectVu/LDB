

describe ProjectMerger do
  it 'have no issues with different ids' do
    pm = described_class.new
    Projektas.new
    Projektas.new(meta_filename: 'metadata2.txt')
    # write ids to both
    fileone = File.open('metadata.txt', 'w')
    filetwo = File.open('metadata2.txt', 'w')
    fileone.puts('projid: 1')
    filetwo.puts('projid: 2')
    fileone.close
    filetwo.close
    expect(pm.prepare_merge('metadata.txt', 'metadata2.txt')).to be true
  end

  it 'do not continue merging when a file is missing' do
    pm = described_class.new
    expect(pm.prepare_merge('nofile.txt', 'nofile2.txt')).to be false
  end

  it 'do not be able to merge into self' do
    pm = described_class.new
    Projektas.new
    fileone = File.open('metadata.txt', 'w')
    fileone.puts('projid: 1')
    fileone.close
    expect(pm.prepare_merge('metadata.txt', 'metadata.txt')).to be false
  end

  it 'finds the manager in metafile' do
    pm = described_class.new
    Projektas.new
    # write manager
    fileone = File.open('metadata.txt', 'w')
    fileone.puts('manager: somename')
    fileone.close
    expect(pm.get_manager_from_meta('metadata.txt')).to eq 'somename'
  end

  it 'do not continue notifying when a file is missing' do
    pm = described_class.new
    expect(pm.notify_managers('nofile.txt', 'nofile2.txt')).to be false
  end

  it 'returns empty string otherwise' do
    pm = described_class.new
    Projektas.new
    expect(pm.get_manager_from_meta('metadata.txt')).to eq ''
  end

  it 'notifies managers of both projects' do
    pm = described_class.new
    Projektas.new
    Projektas.new(meta_filename: 'metadata2.txt')
    fileone = File.open('metadata.txt', 'w')
    filetwo = File.open('metadata2.txt', 'w')
    # set managers to both
    fileone.puts('manager: somename')
    filetwo.puts('manager: othername')
    fileone.close
    filetwo.close
    words = %w[somename othername]
    expect(pm.notify_managers('metadata.txt', 'metadata2.txt')).to eql words
  end
end
