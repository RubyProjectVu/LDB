# frozen_string_literal: true

require_relative 'custom_matcher'
require_relative '../rails_helper'

describe NotesManager do
  fixtures :all

  let(:nm) do
    nm = described_class
    # Check passes - we only care that it happens
    allow(nm).to receive(:bad_words_included?).and_return(true)
    nm
  end

  let(:nml) do
    nml = double
    allow(nml).to receive(:new).and_return(described_class.new)
    allow(nml).to receive(:check_outdated)
    allow(nml).to receive(:list_notes)
    nml
  end

  it 'checks for bad words on creation' do
    nm.create(author: 'auth', name: 'name', text: 'bad')
    expect(nm).to have_received(:bad_words_included?)
  end

  it 'skips checking if name is already bad' do
    nm.create(author: 'auth', name: 'Back', text: 'text')
    expect(nm).not_to have_received(:bad_words_included?)
  end

  it 'lists correct notes' do
    expect(nml.new.list_notes('ar@gmail.com')).to eq %w[Uzrasas1]
  end

  it 'outdated notes are checked before listing' do
    expect(nml.new).to receive(:check_outdated)
    nml.new.list_notes('any')
  end

  it 'similarly, false on non-existing text' do
    described_class.create(author: 'auth', name: 'name', text: 'text')
    nm = described_class.new
    nm.delete_note('name', 'auth')
    expect(nm.note_getter('name', 'auth')).to be false
  end
end
