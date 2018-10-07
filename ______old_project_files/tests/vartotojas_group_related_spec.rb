describe Vartotojas do
  it 'returns true if new work group was created' do
    e = 'jhonpeterson@mail.com'
    vart = described_class.new(name: 'Jhon', last_name: 'Peterson', email: e)
    expect(vart.create_work_group('Marketing')).to be_truthy
  end

  context 'when a user deletes a work group' do
    it 'returns false when nil is being passed to delete_work_group' do
      e = 'jhonpeterson@mail.com'
      vart = described_class.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(vart.delete_work_group(nil)).to be false
    end

    it 'returns true when work group is deleted' do
      group = DarboGrupe.new
      e = 'jhonpeterson@mail.com'
      vart = described_class.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(vart.delete_work_group(group)).to be true
    end

    it 'returns false when work group is already deleted' do
      group = DarboGrupe.new
      e = 'jhonpeterson@mail.com'
      vart = described_class.new(name: 'Jhon', last_name: 'Peterson', email: e)
      vart.delete_work_group(group)
      expect(vart.delete_work_group(group)).to be false
    end
  end
end
