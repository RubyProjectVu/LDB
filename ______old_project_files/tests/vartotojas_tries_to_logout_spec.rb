describe Vartotojas do
  context 'when a user tries to logout' do
    it 'logs out if user exists' do
      # existing user
      e = 't@a.com'
      v1 = described_class.new(name: 'tomas', last_name: 'genut', email: e)
      v1.unique_id_setter('48c7dcc645d82e57f049bd414daa5ae2')

      sys = Sistema.new
      expect(sys.login(v1)).to be true
      # expect(sys.logout(v1)).to equal v1
    end

    it 'returns nil on error' do
      # existing user
      e = 't@a.com'
      v1 = described_class.new(name: 'tomas', last_name: 'genut', email: e)
      v1.unique_id_setter('48c7dcc645d82e57f049bd414daa5ae2')
      expect(Sistema.new.logout(v1)).to be nil
    end
  end
end
