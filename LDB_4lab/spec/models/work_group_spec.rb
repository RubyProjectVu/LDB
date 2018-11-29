# frozen_string_literal: true

require_relative 'custom_matcher'
require_relative '../rails_helper'

describe WorkGroup do
  context 'when a member is being removed from the work_group' do
    it 'true when an existing member gets removed from the work_group' do
      group = described_class.create(projid: 453, budget: 300, name: 'Test')
      group.add_group_member('jhonpeterson@mail.com')
      expect(group.remove_group_member('jhonpeterson@mail.com')).to be true
    end

    it 'false if trying to remove non-existing member from the work_group' do
      group = described_class.create(projid: 453, budget: 300, name: 'Test')
      group.add_group_member('jhon@mail.com')
      expect(group.remove_group_member('jhonpeterson@mail.com')).to be false
    end
  end

  context 'when a new member is being added to the work_group' do
    it 'Returns true when a new member is added to the work_group' do
      group = described_class.create(projid: 453, budget: 300, name: 'Test')
      expect(group.add_group_member('jhonpeterson@mail.com')).to be true
    end

    it 'false if work group member is added again to the same work_group' do
      group = described_class.create(projid: 453, budget: 300, name: 'Test')
      group.add_group_member('jhonpeterson@mail.com')
      expect(group.add_group_member('jhonpeterson@mail.com')).to be false
    end
  end
end
