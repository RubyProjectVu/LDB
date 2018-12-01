# frozen_string_literal: true

require 'date'
require 'etc'
require_relative 'project'
require './application_record'
require 'yaml'

# Manages user notes
class NotesManager < ApplicationRecord
  validates :name, exclusion: { in: %w[Back] }

  attr_reader :state

  before_save do
    throw :abort if self.class.bad_words_included?(text)
  end

  def self.bad_words_included?(text)
    # Could probably be moved to a text file, line by line
    list = %w[bad bad\ word really\ bad\ word]
    list.each do |tx|
      return true if text.match?(tx)
    end
    false
  end

  def check_outdated
    outd = []
    NotesManager.all.each do |note|
      next if [nil].include?(expration = note.expire)

      outd.push(note.name) if expration <= Time.current &&
                              [nil].include?(state)
    end
    remv_outdated(outd) unless [[]].include?(outd)
  end

  def remv_outdated(names)
    return false unless [nil].include?(state)

    names.each do |note|
      NotesManager.find_by(name: note).destroy
    end
  end

  def list_notes(author)
    check_outdated
    populate(author)
  end

  def populate(author)
    arr = []
    NotesManager.all.ids.each do |id|
      note = notet = NotesManager.find_by(id: id)
      arr.push(notet.name) if note.author.eql?(author) && [nil].include?(state)
    end
    arr
  end

  def note_getter(name, author)
    note = NotesManager.find_by(name: name, author: author)
    return false if [nil].include?(note) && [nil].include?(state)

    note.text
  end

  def delete_note(name, author)
    return false unless [nil].include?(state)

    note = NotesManager.find_by(name: name, author: author)
    note.destroy
    true
  end
end
