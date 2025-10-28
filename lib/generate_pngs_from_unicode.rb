require 'fileutils'
require 'json'

INPUT_FILE = 'data/gardiner_hieroglyphs_with_unicode_hex.json'
OUTPUT_DIR = 'data/pngs'
FONT_PATH  = 'lib/font/NotoSansEgyptianHieroglyphs-Regular.ttf'

FileUtils.mkdir_p OUTPUT_DIR

glyphs = JSON.parse(File.read(INPUT_FILE))

glyphs.each do |glyph|
  hieroglyph  = glyph['hieroglyph']
  unicode_hex = glyph['unicode_hex']
  
  next unless !unicode_hex.empty? && !hieroglyph.empty?

  png_path = File.join(OUTPUT_DIR, "#{unicode_hex}.png")

  puts "Generating PNG for '#{hieroglyph}' at #{png_path}"
  system `magick -pointsize 400 -font #{FONT_PATH} label:#{hieroglyph} #{png_path}`
end