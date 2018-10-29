# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/project'
require_relative '../lib/user'

describe Project do
  let(:pr) { described_class.new }
  let(:usr) { User.new }

  context 'when project is validating its metadata, status, owner' do
    #it 'is able to find/open the metadata file created after init' do
     # proj = described_class.new
      #expect(proj.check_metadata).to be true
    #end

    it 'has its owner set correctly' do
      proj = described_class.new
      proj.data_setter('manager', 'some name')
      expect(proj.data_getter('manager')).to eq 'some name'
    end

    it 'sets/returns valid status' do
      proj = described_class.new
      proj.parm_project_status('Proposed')
      expect(proj.parm_project_status).to eq 'Proposed'
    end
  end

  #it do
   # expect(pr.check_metadata).to be true
  #end
end
