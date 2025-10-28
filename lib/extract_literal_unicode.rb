require 'csv'
require 'json'

INPUT_FILE = 'data/gardiner_hieroglyphs.csv'
OUTPUT_FILE = 'data/gardiner_hieroglyphs_with_unicode_hex.json'

# read CSV as array of hashes
glyphs = CSV.parse(File.read(INPUT_FILE), headers: true).map(&:to_h)
glyphs.map! do |glyph|
  # extract literal unicode from hieroglyph field
  begin
    unicode = glyph['hieroglyph'].encode("ASCII") # try to encode it to ASCII
  rescue Encoding::UndefinedConversionError # but if that fails
    unicode= $!.error_char.dump # capture a dump, mapped to the source character
  end
  glyph['unicode_hex'] = unicode.gsub(/[\D]/, '')
  glyph
end

# write to JSON file
File.write(OUTPUT_FILE, JSON.pretty_generate(glyphs))
