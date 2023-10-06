# frozen_string_literal: true

require_relative 'person'
require_relative 'national_insurance_number'
require_relative 'env'

# Class NationalInsuranceReport provides a utility
# to print summaries of people's national insurance numbers along with
# a tally of all national insurance numbers per country.
class NationalInsuranceReport
  attr_accessor :people_details, :ni_report
  attr_reader :spaces

  def initialize(people_details:, spaces: false)
    @spaces = spaces
    @people_details = people_details
    @ni_report = create_report
  end

  def create_report
    LOG.info('Creating national insurance report...')
    people_details.map do |person_details|
      person = Person.new(first_names: person_details['first_names'], last_name: person_details['last_name'])
      ni = NationalInsuranceNumber.new(person: person_details, spaces:).ni_number
      display_ni_numbers(name: person.full_name, ni_number: ni.to_s)
    end
  end

  def print_report(report:, tally:, limit: false)
    report = format_ni_reports(report:)

    if limit
      puts "#{'=' * 40}NATIONAL INSURANCE NUMBERS LIMITED TO #{limit} ENTRIES#{'=' * 40}\n\n#{report[0..limit]}"
    else
      puts "#{'=' * 40}NATIONAL INSURANCE NUMBERS#{'=' * 40}\n\n#{report}"
    end
    puts "\n#{'=' * 28}TALLY#{'=' * 28}\n\n#{tally}"
  end

  def tally_ni_numbers_per_country(report:)
    LOG.info('Tallying national insurance numbers per country...')
    report.map { |arr| arr[1] }
          .map { |num| num[-1] }
          .tally
  end

  private

  def display_ni_numbers(name:, ni_number:)
    [name, ni_number]
  end

  def format_ni_reports(report:)
    report.map { |arr| { 'Name' => arr[0], 'NI Number' => arr[1] } }.flatten
  end
end
