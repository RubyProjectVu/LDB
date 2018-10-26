# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/project_data_checker'
require_relative '../lib/user'

describe ProjectDataChecker do
  let(:pdc) { described_class.new('meta3.txt') }

  before do
    File.write('meta3.txt', 'manager: name')
    File.new('file_to_delete.txt', 'w') # test purposes
  end

  it 'returns false on non existant file deletion' do
    expect(pdc.delete_file('filename.txt')).to be false
  end

  it 'returns true on existing file deletion' do
    expect(pdc.delete_file('file_to_delete.txt')).to be true
  end

  it do
    pdc.delete_file('file_to_delete.txt')
    expect(File.file?('file_to_delete.txt')).to be false
  end

  it do
    pdc.create_file('oo.txt')
    expect(File.file?('oo.txt')).to be true
    File.delete('oo.txt') # test purposes
  end
end
