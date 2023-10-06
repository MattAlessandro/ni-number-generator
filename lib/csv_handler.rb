require 'csv'
require 'simple_symbolize'
require_relative 'env'

# Class CSVHandler provides a lightweight utility to
# read, extract and apply headers to data from a given CSV file.
class CSVHandler
  attr_accessor :file

  def initialize(file: CSV.read('lib/assets/people_data.csv'))
    @file = file
  end

  def apply_headers_to_fields
    LOG.info('Applying csv headers to fields...')
    contents.map { |row| headers.zip(row).to_h }
  end

  private

  def headers
    file[0].map { |header| elementize(header) }
  end

  def contents
    file[1..-1]
  end
end
