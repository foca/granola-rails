class Person
  attr_reader :first_name, :last_name, :age

  def initialize(first_name: nil, last_name: nil, age: nil)
    @first_name = first_name
    @last_name = last_name
    @age = age
  end

  def full_name
    @full_name ||= [first_name, last_name].join(" ")
  end
end
