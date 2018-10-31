# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/project_merger'
require_relative '../lib/project'

describe ProjectMerger do
  it 'finds the manager in metafile' do
    pdc = ProjectDataChecker.new('metadata.txt')
    Project.new
    # write manager
    File.write('metadata.txt', 'manager: somename')
    expect(pdc.manager_from_meta_getter).to eq 'somename'
  end
end
