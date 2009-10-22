module DataMapper
  module ActiveRecordAdapter
    def to_param
      return id
    end
  end
end
