# frozen_string_literal: true

# Some docs here
class ProjectDataChecker
  def initialize(meta)
    @metadata = meta
    @file = meta
  end

  def get_two_metas(file_two)
    return [] unless File.file?(@metadata)

    strtwo = File.read(file_two)
    [own_meta_line_getter, strtwo, '']
  end

  def file_getter
    @file
  end

  def own_meta_line_getter
    File.read(@metadata)
  end

  def manager_from_meta_getter
    File.readlines(@metadata).each do |line|
      # switch to .yml properly later
      return line.partition(' ').last
    end
  end

  def create_file(file_name)
    @file = file_name
    File.new(@file, 'w')
    true
  end

  def delete_file(file_name)
    @file = file_name
    return false unless File.file?(@file)

    File.delete(@file)
    true
  end
end
