module DataMapper
  module SerializationPatch
    def as_json(options = nil, *args)
      options ||= {}
      super(options, *args)
    end
  end
end