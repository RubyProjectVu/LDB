describe Vartotojas do
  context 'when vartotojas creates a new project' do
    it 'returns true when a new project is created' do
      e = 'jhonpeterson@mail.com'
      vart = described_class.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(vart.create_project('Project', 'Project.txt')).to be_truthy
    end
  end
end
