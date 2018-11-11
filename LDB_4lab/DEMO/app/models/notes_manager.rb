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

    NotesManager.create(name: name, author: author, text: text)
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
    note.text
  end

  def delete_note(name)
    note = NotesManager.find_by(name: name)
    note.destroy
    true
  end
end
