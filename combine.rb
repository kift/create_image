require 'RMagick'
include Magick

NUM_ROWS = 3
NUM_COLS = 4

row = NUM_ROWS
col = NUM_COLS
ilg = ImageList.new
1.upto(col) {|x| il = ImageList.new
1.upto(row) {|y| il.push(Image.read("output/fill-" + (y + (x-1)*col).to_s + ".png").first)}
ilg.push(il.append(false))}
ilg.append(true).write("output/combine_out.png")