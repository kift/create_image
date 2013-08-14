require 'RMagick'
include Magick

NUM_ROWS = 3
NUM_COLS = 3

RESIZE_WIDTH = 250
RESIZE_HEIGHT = 250

row = NUM_ROWS
col = NUM_COLS


for i in 1..10 do

	ilg = ImageList.new
	1.upto(col) {|x| il = ImageList.new
	1.upto(row) {|y| il.push(Image.read("output/category#{y + (x-1)*col}/colortext#{i}.png").first.resize_to_fill(RESIZE_WIDTH, RESIZE_HEIGHT))}
	ilg.push(il.append(false))}
	ilg.append(true).write("output/combine_c#{i}.png")

end