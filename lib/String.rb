# frozen_string_literal: true

# Monkey-patching string class, adding new method to remove all whitespace from a string
class String
  def remove_all_whitespace
    gsub(/\s+/, '')
  end
end
