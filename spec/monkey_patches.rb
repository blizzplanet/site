module DataMapper
  module Resource
    def save!(*args, &block)
      save(*args, &block) || raise("Couldn't save #{self.class.name} -- #{self.valid?} -- #{self.errors.inspect}")
    end
  end
end