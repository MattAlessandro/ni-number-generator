require_relative 'lib/national_insurance_number'
require_relative 'lib/national_insurance_report'
require_relative 'lib/csv_handler'

people_csv = CSVHandler.new

people_details = people_csv.apply_headers_to_fields
report = NationalInsuranceReport.new(people_details:)
ni_report = report.ni_report
tally = report.tally_ni_numbers_per_country(report: ni_report)
report.print_report(report: ni_report, tally:, limit: 20)
