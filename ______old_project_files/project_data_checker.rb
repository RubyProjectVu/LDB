# Some docs here
class ProjectDataChecker
  attr_reader :metadata
  attr_reader :file

  def initialize(meta)
    @metadata = meta
    @file = ''
  end

  def get_two_metas(file_two)
    [] unless File.file?(@metadata)
    file_two = File.open(file_two, 'r')
    strtwo = file_two.gets
    file_two.close
    [own_meta_line_getter, strtwo]
  end

  def own_meta_line_getter
    @file = File.open(@metadata, 'r')
    strone = @file.gets
    @file.close
    strone
  end

  def manager_from_meta_getter
    str = ''
    File.readlines(@metadata).each do |line|
      part = line.partition(' ').last.chomp
      # puts part
      # str = line.partition(' ').last.chomp if line.start_with? 'manager:'
      str = part # if part.start_with? 'manager:'
    end
    # puts str
    str
  end

  def create_file(file_name)
    @file = ''
    File.new(file_name, 'w')
    true
  end

  def delete_file(file_name)
    @file = ''
    if File.delete(file_name) == 1 # var == 1
      file = File.new(file_name, 'w') # TEST PURPOSES
      file.puts('a') # TEST PURPOSES
      true
    end
  rescue StandardError
    false
  end
end
