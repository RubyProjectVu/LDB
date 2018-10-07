describe Vartotojas do
  context 'when a user uploads qualification certificates' do
    it 'returns true if file is accepted' do
      v1 = described_class.new(name: 'tomas', last_name: 'genut',
                               email: 't@a.com')
      v1.unique_id_setter
      expect(v1.upload_certificate('file.docx')).to be true
      # expect(v1.upload_certificate('file.doc')).to be true
      # expect(v1.upload_certificate('file.pdf')).to be true
    end

    it 'returns false if file is of wrong format' do
      v1 = described_class.new(name: 'tomas', last_name: 'genut',
                               email: 't@a.com')
      v1.unique_id_setter
      expect(v1.upload_certificate('file.ff')).to be false
      # expect(v1.upload_certificate('file.exe')).to be false
      # expect(v1.upload_certificate('file.png')).to be false
      # expect(v1.upload_certificate('.gimp')).to be false
      # expect(v1.upload_certificate('.doc')).to be false
      # expect(v1.upload_certificate('.pdf')).to be false
      # expect(v1.upload_certificate('.docx')).to be false
    end
  end
end
