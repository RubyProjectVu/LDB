# frozen_string_literal: true

require_relative 'custom_matcher'
require_relative '../rails_helper'

describe Search do
  fixtures :all

  let(:src) { described_class.new }

  let(:srstub) {
    srstub = double
    allow(srstub).to receive(:gather_data)
    allow(srstub).to receive(:new).and_return(Search.new)
    allow(srstub).to receive(:search_by_criteria)
    srstub
  }

  it 'does not call data gathering with nil criteria' do
    expect(srstub.new).not_to receive(:gather_data)
    srstub.new.search_by_criteria(['Anything'], nil)
  end

  it 'calls search if criteria is not nil' do
    expect(srstub.new).to receive(:gather_data)
    srstub.new.search_by_criteria(['User'], 'anyval')
  end

  it 'instance is always holding a true value' do
    expect(src.parm_instancevariable).to be true
  end

  it 'no value returns empty string array' do
    expect(src.search_by_criteria(['Project'], 'noval')).to start_with([''])
  end

  it 'something is detected - message is returned' do
    expect(src.search_by_criteria(['User'],
                                  'Greblys')).to eq [['User has: ',
                                                    'Greblys']]
  end

  it 'handles multiple criteria' do
    expect(described_class.new.search_by_criteria(%w[WorkGroup
                                                     User], 'Darbo grupe'))
      .to start_with [%w[WorkGroup\ has:\  Darbo\ grupe]]
  end

  it 'result is delivered as an array of messages plus actual strings' do
    expect(described_class.new.search_by_criteria(%w[WorkGroup
                                                     Project
                                                     User], 'Antanas'))
      .to all be_an(Array).or be_an(String)
  end

  it 'sets correctly on instvar' do
    expect(src.parm_instancevariable(false)).to be false
  end

  it 'search failure adds an ampty string anyway' do
    expect(described_class.new.search_by_criteria(%w[User], 'noval'))
      .to end_with ['']
  end
end
