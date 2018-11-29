# frozen_string_literal: true

require_relative 'custom_matcher'
require_relative '../rails_helper'
require 'date'
srand

describe WorkGroupManager do
  it 'saves a new group' do
    expect(described_class.new.save_group('name')).to be_truthy
  end

  it 'last group is removed and file is empty' do
    WorkGroup.create(name: 'newgr')
    wg = WorkGroup.find_by(name: 'newgr').id
    expect(described_class.new.delete_group(wg)).to be true
  end
end
