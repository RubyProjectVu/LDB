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

  it 'checks for bad words on creation' do
    nm.create(author: 'auth', name: 'name', text: 'bad')
    expect(nm).to have_received(:bad_words_included?)
  end

  it 'skips checking if name is already bad' do
    nm.create(author: 'auth', name: 'Back', text: 'text')
    expect(nm).not_to have_received(:bad_words_included?)
  end
 
  it 'does not call removing method if there are no expired notes' do
    NotesManager.find_by(name: 'Uzrasas3').destroy
    nm = described_class.new
    allow(nm).to receive(:remv_outdated)
    nm.list_notes('ar@gmail.com')
    expect(nm).not_to have_received(:remv_outdated)
  end

  it 'lists correct notes' do
    nm = described_class.new
    nm.state = true
    expect(nm.list_notes('ar@gmail.com')).to eq %w[Uzrasas1]
  end

  it 'similarly, false on non-existing text' do
    nm = described_class.new
    nm.state = true
    nm.delete_note('Uzrasas1', 'ar@gmail.com')
    expect(nm.note_getter('Uzrasas1', 'ar@gmail.com')).to be false
  end
end
