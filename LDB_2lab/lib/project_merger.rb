# frozen_string_literal: true

require_relative 'project_data_checker'

# Controls project merges
class ProjectMerger
  def initialize
    @attrib = []
  end

  def prepare_merge(meta_one, meta_two)
    return false unless File.file?(meta_one)

    return false unless File.file?(meta_two)

    @attrib = ProjectDataChecker.new(meta_one).get_two_metas(meta_two)
    return false if @attrib.fetch(0).eql? @attrib.fetch(1)

    true
  end

  def notify_managers(meta_one, meta_two)
    # should ideally postpone this until agreement is reached
    return false unless File.file?(meta_one)

    return false unless File.file?(meta_two)

    @attrib[0] = ProjectDataChecker.new(meta_one).manager_from_meta_getter
    @attrib[1] = ProjectDataChecker.new(meta_two).manager_from_meta_getter
    @attrib
  end
end
