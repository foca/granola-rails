class PersonSerializer < Granola::Serializer
  def data
    {
      name: object.full_name,
      age: object.age,
    }
  end
end
