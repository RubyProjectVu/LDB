# frozen_string_literal: true

require_relative 'custom_matcher'
require_relative '../rails_helper'

describe Order do
  fixtures :all

  let(:bm) do
    bm = BudgetManager.new
    # Only care if we receive checking
    allow(bm).to receive(:can_deduct_more).and_return(true)
    bm
  end

  let(:order) do
    order = described_class.create(material: 'Planks', provider: 'WoodWorks',
                                   projid: 'any', cost: 540, qty: 5)
    # The validity of cost is not important right now
    allow(order).to receive(:valid_cost).and_return(true)
    order
  end

  it 'checks if the budget is large enough for order' do
    Project.create(id: 'any', budget: '0')
    order = described_class.create(material: 'Planks', provider: 'WoodWorks',
                                   projid: 'any', cost: 540, qty: 5)
    order.deduct_budget(order.cost, bm)
    expect(bm).to have_received(:can_deduct_more)
  end

  it 'checks whether the cost is indeed = ppu * qty' do
    Project.create(id: 'any', budget: '0')
    order.deduct_budget(order.cost, bm)
    expect(order).to have_received(:valid_cost)
  end
end
