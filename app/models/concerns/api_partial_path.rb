module ApiPartialPath
  def to_partial_path
    "api/#{self.class.model_name.singular}.json"
  end
end
