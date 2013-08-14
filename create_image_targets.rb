require 'RMagick'

FONTS = ['/Library/Fonts/Jazz LET Fonts', '/Library/Fonts/Microsoft/Lucida Handwriting']
DOLL_TYPE = "QLRB_Bear"

class ImageTarget
	def initialize(width=500, length=500)
		@width = width
		@length = length
	  white = Magick::Image.new(width, length) { self.background_color = 'white'}
	  fill = Magick::TextureFill.new(white)
		@img = Magick::ImageList.new
		@img.new_image(width, length, fill)
		self.fill_text
	end

	attr_accessor :width
	attr_accessor :length
	attr_accessor :img

	def fill_text
	  text1 = ('a'..'z').to_a.shuffle[0,20].join + "\n" + ('a'..'z').to_a.shuffle[0,20].join + "\n" \
        	+ ('a'..'z').to_a.shuffle[0,20].join + "\n" + ('a'..'z').to_a.shuffle[0,20].join + "\n" \
        	+ ('a'..'z').to_a.shuffle[0,20].join 
		text2 = ('A'..'Z').to_a.shuffle[0..1].join + "\n" + ('A'..'Z').to_a.shuffle[0..1].join

	  ann1 = Magick::Draw.new
	  ann1.annotate(@img, 0, 0, 0, 25, text1) {
	    self.gravity = Magick::CenterGravity
	    
	    self.fill = "##{"%02x" % (rand * 0x60) }#{"%02x" % (rand * 0x40) }#{"%02x" % (rand * 0x00) }80"
	    self.font = FONTS[1].to_s
	    self.pointsize = 133
	    self.interline_spacing = -66
	  }

	  ann2 = Magick::Draw.new
	  ann2.annotate(@img, 0, 0, 0, 50, text2) {
	    self.gravity = Magick::CenterGravity
	    self.fill = "##{"%02x" % (rand * 0x60) }#{"%02x" % (rand * 0x10) }#{"%02x" % (rand * 0x60) }80"
	    self.font = FONTS[0].to_s
	    self.pointsize = 250
	    self.interline_spacing = -100
	  }  		
	end

	protected :fill_text

	def save_as_file
		@img.write("PNG8:output/raw_image.png")
		puts "created: output/raw_image.png"
	end
end


class ImageTargetWithWhiteFrame
	def initialize(image_target= ImageTarget.new)
		@image_target = image_target
	end

	def add_white_frame
		##
	end
end

class ARImageTarget < ImageTargetWithWhiteFrame
	def initialize(image_target= ImageTarget.new)
		super
		@ar_image_target
		add_white_frame
	end

	def add_white_frame
		@width = @image_target.width * 2
		@length = @image_target.length * 2

	  @imgwh = Magick::Image.new(@width, @length) {
	    self.background_color = 'white'
	  }
	  @ar_image_target = @imgwh.composite(@image_target.img, Magick::CenterGravity, 0, 0, Magick::MultiplyCompositeOp)		
	end

	attr_accessor :width
	attr_accessor :length

	def save_as_file
		@ar_image_target.write("PNG8:output/ar_image_target.png")
		puts "created: output/ar_image_target.png"
	end	
end

class PrintableImageTarget < ImageTargetWithWhiteFrame
	
end