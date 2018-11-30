# frozen_string_literal: true

require 'date'
require 'etc'
require_relative 'project'
require './application_record'
require 'yaml'

# Manages user notes
class NotesManager < ApplicationRecord
  validates :name, exclusion: { in: %w[Back] }

  before_save do
    throw :abort if self.class.bad_words_included?(self.text)
  end

  def self.bad_words_included?(text)
    # Could probably be moved to a text file, line by line
    list = %w[bad bad\ word really\ bad\ word]
    list.each do |t|
      return true if text.match?(t)
    end
    false
  end

  def check_outdated
    outd = []
    list = NotesManager.all
    list.each do |note|
      next if [nil].include?(note.expire)

      outd.push(note.name) if note.expire <= DateTime.current
    end
    outd
  end

  def list_notes(author)
    check_outdated
    arr = []
    lofids = NotesManager.all.ids
    lofids.each do |id|
      note = NotesManager.find_by(id: id)
      arr.push(note.name) if note.author.eql?(author)
    end
    arr
  end

  def note_getter(name, author)
    note = NotesManager.find_by(name: name, author: author)
    return false if [nil].include?(note)

    note.text
  end

  def delete_note(name, author)
    note = NotesManager.find_by(name: name, author: author)
    note.destroy
    true
  end
end
