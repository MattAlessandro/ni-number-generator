# frozen_string_literal: true

# class Person provides a lightweight utility for storing a person's first and last names and returning their full name.
class Person
  attr_accessor :first_names, :last_name

  def initialize(first_names:, last_name:)
    @first_names = first_names
    @last_name = last_name
  end

  def full_name
    "#{first_names} #{last_name}"
  end
end
