# Controls project merges
class Project_merger
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
    manone = ''
    mantwo = ''
    File.readlines(meta_one).each do |line|
      if line.start_with? 'manager'
        manone = line.partition(': ').last.chomp
      end
    end
    File.readlines(meta_two).each do |line|
      if line.start_with? 'manager'
        mantwo = line.partition(': ').last.chomp
      end
    end
    # notification
    [manone, mantwo]
  end
end