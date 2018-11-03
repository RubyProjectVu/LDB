# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/notes_manager'
require_relative 'custom_matcher'
require_relative '../lib/project'

describe NotesManager do
  let :nm do
    described_class.new
  end

  after do
    # Butina - kitaip mutant sumauna notes.yml faila ir klasiu kintamuosius.
    hash = { 'wow' => { 'author' => 'user', 'text' => 'example' } }
    other = { 'badtext' => { 'author' => 'somename', 'text' => 'bad word' } }
    File.open('notes.yml', 'w') do |fl|
      fl.write hash.to_yaml.gsub('---', '')
      fl.write other.to_yaml.gsub('---', '')
    end
  end

  it do
    expect(nm.save_note('auth', 'name', 'text')).to contain_exactly(
      ['badtext', { 'author' => 'somename', 'text' => 'bad word' }],
      ['wow', { 'author' => 'user', 'text' => 'example' }]
    )
  end

  it do
    expect(nm.save_note('auth', 'Back', 'text')).to be false
  end

  it do
    nm.save_note('auth', 'name', 'text')
    hash = YAML.load_file('notes.yml')
    expect(hash['name']['author']).to eq 'auth'
  end

  it do
    expect(nm.list_notes).to eq %w[wow badtext]
  end

  it do
    expect(nm.note_getter('wow')).to eq 'example'
  end

  it do
    expect(nm.delete_note('wow')).to be true
  end

  it do
    nm.delete_note('wow')
    hash = YAML.load_file('notes.yml')
    expect(hash).to eq 'badtext' => { 'author' => 'somename',
                                      'text' => 'bad word' }
  end

  it do
    expect(YAML.load_file('notes.yml')['wow']['text']).not_to has_bad_words
  end

  it do
    expect(YAML.load_file('notes.yml')['badtext']['text']).to has_bad_words
  end
end
