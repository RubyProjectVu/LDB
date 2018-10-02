# Controls project merges
class ProjectMerger
  def prepare_merge(meta_one, meta_two)
    return false if !File.file?(meta_one) || !File.file?(meta_two)

    fileone = File.open(meta_one, 'r')
    strone = fileone.gets
    fileone.close
    filetwo = File.open(meta_two, 'r')
    strtwo = filetwo.gets
    filetwo.close

    return false if strone.eql? strtwo

    true
  end

  def notify_managers(meta_one, meta_two)
    # should ideally postpone this until agreement is reached
    return false if !File.file?(meta_one) || !File.file?(meta_two)

    # return false if prepare_merge(meta_one, meta_two)
    arr = []
    arr[0] = get_manager_from_meta(meta_one)
    arr[1] = get_manager_from_meta(meta_two)
    arr
  end

  def get_manager_from_meta(meta)
    str = ''
    File.readlines(meta).each do |line|
      # manone =
      str = line.partition(' ').last.chomp if line.start_with? 'manager:'
    end
    str
  end
end
