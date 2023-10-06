# frozen_string_literal: true

require_relative 'string'

# Class NationalInsuranceNumber provides a simple national insurance utility
# to generate unique National Insurance numbers for individuals.
class NationalInsuranceNumber
  UK_COUNTRIES = %w[W E S N].freeze

  attr_accessor :person, :ni_number
  attr_reader :spaces

  def initialize(person:, spaces:)
    @spaces = spaces
    @person = person
    @ni_number = generate_ni_number
  end

  private

  def generate_ni_number
    ni_number = "#{name} #{year} #{random_code} #{country_of_birth}"
    spaces ? ni_number : ni_number.remove_all_whitespace
  end

  def name
    # First letter of first_name + First letter of person's last name.
    person['first_names'][0] + person['last_name'][0]
  end

  def year
    person['date_of_birth'].split('-').first[-2..]
  end

  def random_code
    format('%04d', rand(10_000))
  end

  def country_of_birth
    country = person['country_of_birth']
    UK_COUNTRIES.include?(country[0]) ? country[0] : 'O'
  end
end
