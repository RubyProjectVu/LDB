# frozen_string_literal: true

require 'date'
require 'etc'
require_relative 'project'
require 'yaml'

# Manages user notes
class NotesManager
  def initialize
    @notes = YAML.load_file('notes.yml')
  end

  def save_note(author, name, text)
    return false if name.eql?('Back')

    hash = { name => { 'author' => author, 'text' => text } }
    File.open('notes.yml', 'a') { |fl| fl.write hash.to_yaml.sub('---', '') }
    @notes
  end

  def list_notes
    arr = []
    @notes.each_key do |key|
      arr.push(key)
    end
    arr
  end

  def note_getter(name)
    @notes.fetch(name).fetch('text')
  end

  def delete_note(name)
    @notes.delete(name)
    File.open('notes.yml', 'w') do |fl|
      fl.write @notes.to_yaml.sub('---', '').sub('{}', '')
    end
    true
  end
end
