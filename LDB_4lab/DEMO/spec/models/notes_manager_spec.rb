# frozen_string_literal: true

require_relative 'custom_matcher'
require_relative '../rails_helper'

describe NotesManager do
  fixtures :all

  let(:nm) {
    nm = double
    allow(nm).to receive(:new).and_return(NotesManager.new)
    allow(nm).to receive(:save_note)
    allow(nm).to receive(:bad_words_included?)
    nm
  }

  let(:nml) {
    nml = double
    allow(nml).to receive(:new).and_return(NotesManager.new)
    allow(nml).to receive(:check_outdated)
    allow(nml).to receive(:list_notes)
    nml
  }

  it 'checks for bad words on creation' do
    expect(nm.new).to receive(:bad_words_included?)
    nm.new.save_note('auth', 'name', 'text')
  end

  it 'skips checking if name is already bad' do
    expect(nm).not_to receive(:bad_words_included?)
    nm.save_note('auth', 'Back', 'text')
  end

  it 'author is saved' do
    nm = NotesManager.new
    nm.save_note('auth', 'name1', 'text')
    note = NotesManager.find_by(name: 'name1')
    expect(note.author).to eq 'auth'
  end

  it 'text is saved' do
    nm = NotesManager.new
    nm.save_note('auth', 'name2', 'text')
    note = NotesManager.find_by(name: 'name2')
    expect(note.text).to eq 'text'
  end

  it 'lists correct notes' do
    expect(nml.new.list_notes).to eq %w[Uzrasas2 Uzrasas1]
  end

  it 'outdated notes are checked before listing' do
    expect(nml.new).to receive(:check_outdated)
    nml.new.list_notes
  end

  it 'retrieves text correctly not through ActiveRecord' do
    nm = NotesManager.new
    nm.save_note('auth', 'name', 'text')
    expect(nm.note_getter('name')).to eq 'text'
  end

  it 'similarly, false on non-existing text' do
    nm = NotesManager.new
    nm.save_note('auth', 'name', 'text')
    nm.delete_note('name')
    expect(nm.note_getter('name')).to be false
  end
end
