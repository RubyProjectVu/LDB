describe Vartotojas do
  context 'when vartotojas deletes a project' do
    it 'returns false when nil is being passed to delete_project' do
      e = 'jhonpeterson@mail.com'
      vart = described_class.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(vart.delete_project(nil)).to be false
    end

    it 'returns true when project is deleted' do
      proj = Projektas.new
      e = 'jhonpeterson@mail.com'
      vart = described_class.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(vart.delete_project(proj)).to be true
    end

    it 'returns false when project is already deleted' do
      proj = Projektas.new
      e = 'jhonpeterson@mail.com'
      vart = described_class.new(name: 'Jhon', last_name: 'Peterson', email: e)
      vart.delete_project(proj)
      expect(vart.delete_project(proj)).to be false
    end
  end
end
