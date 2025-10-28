# NOTE: requires system imagemagick install for `magick` command

require 'fileutils'
require 'json'

INPUT_FILE = 'data/gardiner_hieroglyphs_with_unicode_hex.json'
OUTPUT_DIR = 'data/pngs'
FONT_PATH  = 'lib/font/NotoSansEgyptianHieroglyphs-Regular.ttf'

FileUtils.mkdir_p OUTPUT_DIR

# read JSON as array of (glyph) hashes
glyphs = JSON.parse(File.read(INPUT_FILE))

glyphs.each do |glyph|
  hieroglyph  = glyph['hieroglyph']
  unicode_hex = glyph['unicode_hex']
  png_path    = File.join(OUTPUT_DIR, "#{unicode_hex}.png")
  
  next unless !unicode_hex.empty? && !hieroglyph.empty?

  puts "Generating PNG for '#{hieroglyph}' at #{png_path}"

  # direct system call instead of using rgmaick gem (lazy)
  # takes the UTF glyph directly as label arg, generates & saves image representation
  system `magick -pointsize 400 -font #{FONT_PATH} label:#{hieroglyph} #{png_path}`
end
