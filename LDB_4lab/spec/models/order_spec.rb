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

  it 'checks if the budget is large enough for order' do
    Project.create(id: 'any', budget: '0')
    order = described_class.create(material: 'Planks', provider: 'WoodWorks',
                                   projid: 'any', cost: '540')
    order.deduct_budget(order.cost, bm)
    expect(bm).to have_received(:can_deduct_more)
  end
end
