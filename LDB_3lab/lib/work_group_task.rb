class WorkGroupTask
  def initialize(text)
    @data = {text: text}
  end

  def data_getter(key)
    @data.fetch(key.to_sym)
  end

  def data_setter(key, val)
    @data[key.to_sym] = val
  end
end
