require 'RMagick'

for i in 1..10 do

	# TEXTCONTEXT = ('A'..'Z').to_a.shuffle[0..1].join
	textarray = ['藺','霾','魘','赧','羈','梟','覷','肇','竇','蠲']
	backgroundcolor = "##{"%06x" % (rand * 0xffffff)}"
	font = 'fonts/wt021.ttf'


	source = Magick::Image.new(250, 250) { self.background_color = backgroundcolor }

	contenttext = Magick::Draw.new
	contenttext.font = font
	contenttext.pointsize = 80
	contenttext.font_weight = Magick::BoldWeight
	contenttext.fill = 'white'
	contenttext.gravity = Magick::CenterGravity
	contenttext.annotate(source, 0, 0, 0, 0, textarray[i-1].to_s)
	source.write("output/colortext#{i}.png")

end