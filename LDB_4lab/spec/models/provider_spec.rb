# frozen_string_literal: true

require_relative 'custom_matcher'
require_relative '../rails_helper'

describe Provider do
  fixtures :all

  let(:prov) do
    prov = described_class.find_by(name: 'SteelPool')
    # The true fact whether there are any offers is irrelevant
    allow(prov).to receive(:offers?).and_return(true)
    prov
  end

  it 'always checks whether there are offers before fetching them' do
    prov.materials_by_provider
    expect(prov).to have_received(:offers?)
  end

  it 'has offers when it has offers' do
    expect(described_class.new(name: 'WoodWorks').offers?).to be true
  end

  it 'vice versa' do
    expect(described_class.new(name: 'noCompany').offers?).to be false
  end

  it 'false when no offers' do
    expect(described_class.new(name: 'noCompany').materials_by_provider)
      .to be false
  end

  it 'actual materials retrieved' do
    expect(described_class.new(name: 'WoodWorks').materials_by_provider)
      .to eq %w[Planks Boards]
  end
end
