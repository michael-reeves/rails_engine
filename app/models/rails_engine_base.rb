module RailsEngineBase
  def find(params)
    key   = params.first.first
    value = params.first.last

    if params
      if value.is_a?(Numeric)
        self.where("#{key} = ?", value).first
      else
        self.where("LOWER(#{key}) LIKE ?", value.downcase).first
      end
    else
      "Record not found."
    end
  end

  def find_all(params)
    key   = params.first.first
    value = params.first.last

    if params
      if value.is_a?(Numeric)
        self.where("#{key} = ?", value)
      else
        self.where("LOWER(#{key}) LIKE ?", value.downcase)
      end
    else
      "Record not found."
    end
  end

  def random
    self.order('RANDOM()').first
  end
end
