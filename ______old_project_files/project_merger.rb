require_relative 'project_data_checker'

# Controls project merges
class ProjectMerger
  attr_reader :attrib

  def initialize
    @attrib = []
  end

  def prepare_merge(meta_one, meta_two)
    return false if !File.file?(meta_one) || !File.file?(meta_two)

    # fileone = File.open(meta_one, 'r')
    # strone = fileone.gets
    # fileone.close
    # filetwo = File.open(meta_two, 'r')
    # strtwo = filetwo.gets
    # filetwo.close
    # arr = get_two_metas(meta_one, meta_two)
    @attrib = ProjectDataChecker.new(meta_one).get_two_metas(meta_two)

    # return false if strone.eql? strtwo
    return false if @attrib[0].eql? @attrib[1]

    true
  end

<<<<<<< HEAD
  def get_two_metas(file_one, file_two)
    [File.readlines(file_one), File.readlines(file_two)]
  end
=======
  # def get_two_metas(file_one, file_two)
  #  file_one = File.open(file_one, 'r')
  #  strone = file_one.gets
  #  file_one.close
  #  file_two = File.open(file_two, 'r')
  #  strtwo = file_two.gets
  #  file_two.close
  #  [strone, strtwo]
  # end
>>>>>>> paulius

  def notify_managers(meta_one, meta_two)
    # should ideally postpone this until agreement is reached
    return false if !File.file?(meta_one) || !File.file?(meta_two)

    # return false if prepare_merge(meta_one, meta_two)
    # arr = []
    @attrib[0] = ProjectDataChecker.new(meta_one).manager_from_meta_getter
    @attrib[1] = ProjectDataChecker.new(meta_two).manager_from_meta_getter
    @attrib
  end

  # def get_manager_from_meta(meta)
  #  str = ''
  #  File.readlines(meta).each do |line|
  #    str = line.partition(' ').last.chomp if line.start_with? 'manager:'
  #  end
  #  str
  # end
end
