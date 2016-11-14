class DetailedPersonSerializer < Granola::Serializer
  def data
    {
      first_name: object.first_name,
      last_name: object.last_name,
      age: object.age,
    }
  end
end
