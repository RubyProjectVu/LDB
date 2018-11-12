# frozen_string_literal: true

#require 'simplecov'
#SimpleCov.start

#require_relative '../lib/notes_manager'
require_relative 'custom_matcher'
#require_relative '../lib/project'
require_relative '../rails_helper'

describe NotesManager do
  let :nm do
    nm = double(:NotesManager)
    allow(nm).to receive(:save_note)
    allow(nm).to receive(:bad_words_included?)
    allow(nm).to receive(:list_notes)
    allow(nm).to receive(:note_getter)
  end

  it do
    nm = NotesManager.new#.save_note('a', 'a', 'bad')
    #allow(nm).to receive(:save_note)
    #allow(nm).to receive(:bad_words_included?)
    #nm = double(:NotesManager).as_null_object
    expect(nm).to receive(:bad_words_included?)
    nm.save_note('auth', 'name', 'text')
    # expect(nm).to have_received(:bad_words_included?)
  end

  it do
    #allow(nm).to receive(:bad_words_included?)
    nm = NotesManager.new
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

  it do
    nm = NotesManager.new
    nm.save_note('auth', 'name', 'text')
    expect(nm.list_notes).to eq %w[name]
  end

  it do
    nm = NotesManager.new
    nm.save_note('auth', 'name', 'text')
    expect(nm.note_getter('name')).to eq 'text'
  end

  it do
    nm = NotesManager.new
    nm.save_note('auth', 'name', 'text')
    nm.delete_note('name')
    expect(nm.note_getter('name')).to be false
  end
end
