# frozen_string_literal: true

require_relative 'custom_matcher'
require_relative '../rails_helper'

describe Provider do
  fixtures :all

  let(:prov) do
    prov = described_class.find_by(name: 'SteelPool')
    # The true fact whether there are any offers is irrelevant
    allow(prov).to receive(:has_offers).and_return(true)
    prov
  end

  it 'always checks whether there are offers before fetching them' do
    prov.materials_by_provider
    expect(prov).to have_received(:has_offers)
  end
end
