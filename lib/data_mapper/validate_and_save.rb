module DataMapper
  module ValidateAndSave
    def validate_and_save
      if !save
        raise self.errors.to_s
      end
    end
  end
end
