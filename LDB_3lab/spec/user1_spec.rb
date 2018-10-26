# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/user'
require_relative '../lib/system'

describe User do
  context 'when a user uploads qualification certificates' do
    it 'returns true if file is accepted' do
      v1 = described_class.new(name: 'tomas', last_name: 'genut',
                               email: 't@a.com')
      expect(v1.upload_certificate('file.docx') &&
             v1.upload_certificate('file.doc') &&
             v1.upload_certificate('file.pdf')).to be true
    end

    it 'returns false if file is of wrong format' do
      v1 = described_class.new(name: 'tomas', last_name: 'genut',
                               email: 't@a.com')
      expect(v1.upload_certificate('file.ff') ||
             v1.upload_certificate('file.exe') ||
             v1.upload_certificate('file.png')).to be false
    end

    it 'returns false if file is of without formatting' do
      v1 = described_class.new(name: 'tomas', last_name: 'genut',
                               email: 't@a.com')
      expect(v1.upload_certificate('.doc') ||
             v1.upload_certificate('.pdf')).to be false
    end
  end
end
