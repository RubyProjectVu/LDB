# frozen_string_literal: true

require 'date'
require 'etc'
require_relative 'project'
require './application_record'
require 'yaml'

# Manages user notes
class NotesManager < ApplicationRecord
  def save_note(author, name, text)
    return false if name.eql?('Back')

    NotesManager.create(name: name, author: author, text: text) unless bad_words_included?(text)
  end

  def bad_words_included?(text)
    # Could probably be moved to a text file, line by line
    list = %w[bad bad\ word really\ bad\ word]
    list.each do |t|
      return true if text.match?(t)
    end
    false 
  end

  def list_notes
    arr = []
    lofids = NotesManager.all.ids
    lofids.each do |id|
      arr.push(NotesManager.find_by(id: id).name)
    end
    arr
  end

  def note_getter(name)
    note = NotesManager.find_by(name: name)
    return false if [nil].include?(note)
    note.text
  end

  def delete_note(name)
    note = NotesManager.find_by(name: name)
    note.destroy
    true
  end
end
