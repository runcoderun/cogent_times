module DataMapper
  module ValidateAndSave
    def validate_and_save
      if !save
        text = (self.errors.collect &:to_s).join(', ')
        raise text
      end
      return self
    end
  end
end
