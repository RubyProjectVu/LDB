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
    return false if name.eql?('Back') || @notes == false
    return false if @notes.key?(name)

    hash = { name => { 'author' => author, 'text' => text } }
    File.open('notes.yml', 'a') { |fl| fl.write hash.to_yaml.sub('---', '') }
    true
  end

  def list_notes
    arr = []
    IO.foreach('notes.yml') do |line|
      if !line.split(/:/).first.start_with?(' ', '\'', "\n")
        arr.push(line.split(/:/).first)
      end
    end
    arr
  end

  def note_getter(name)
    @notes.fetch(name).fetch('text')
  end

  def delete_note(name)
    
  end
end
