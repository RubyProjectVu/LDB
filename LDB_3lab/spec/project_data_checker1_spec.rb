# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/project_data_checker'
require_relative '../lib/user'

describe ProjectDataChecker do
  let(:pdc) { described_class.new('meta3.txt') }

  before do
    File.write('meta3.txt', 'manager: name')
    File.write('metadata2.txt', 'manager: othername')
  end

  it do
    expect(pdc.create_file('temp.txt')).to be true
  end

  it do
    expect(pdc.own_meta_line_getter).to eq 'manager: name'
  end

  it do
    expect(pdc.get_two_metas('metadata2.txt')).to eq ['manager: name',
                                                      'manager: othername', '']
  end

  it do
    File.delete('meta3.txt')
    expect(pdc.get_two_metas('doesntmatter.txt')).to eq []
  end

  it do
    expect(pdc.manager_from_meta_getter).to eq 'name'
  end

  it do
    expect(pdc.file_getter).to eq 'meta3.txt'
  end
end
