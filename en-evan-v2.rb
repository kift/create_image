# 
# 
#

require 'RMagick'

fonts = ['/Library/Fonts/Webdings.ttf', '/Library/Fonts/Party LET Fonts', '/Library/Fonts/Jazz LET Fonts', '/Library/Fonts/Microsoft/Lucida Handwriting']
DOLL_TYPE = "QLRB_Bear"

20.times { |i|

  text1 = ('a'..'z').to_a.shuffle[0,20].join + "\n" + ('a'..'z').to_a.shuffle[0,20].join + "\n" \
          + ('a'..'z').to_a.shuffle[0,20].join + "\n" + ('a'..'z').to_a.shuffle[0,20].join + "\n" \
          + ('a'..'z').to_a.shuffle[0,20].join 
  text2 = ('A'..'Z').to_a.shuffle[0..1].join + "\n" + ('A'..'Z').to_a.shuffle[0..1].join


  white = Magick::Image.new(500, 500) { self.background_color = 'white'}
  fill = Magick::TextureFill.new(white)
  img = Magick::ImageList.new
  img.new_image(500, 500, fill)


  ann1 = Magick::Draw.new
  ann1.annotate(img, 0, 0, 0, 25, text1) {
      self.gravity = Magick::CenterGravity
      
      self.fill = "##{"%02x" % (rand * 0x60) }#{"%02x" % (rand * 0x40) }#{"%02x" % (rand * 0x00) }80"
      self.font = fonts[3].to_s
      self.pointsize = 133
      self.interline_spacing = -66
      }

  ann2 = Magick::Draw.new
  ann2.annotate(img, 0, 0, 0, 50, text2) {
      self.gravity = Magick::CenterGravity
      self.fill = "##{"%02x" % (rand * 0x60) }#{"%02x" % (rand * 0x10) }#{"%02x" % (rand * 0x60) }80"
      self.font = fonts[2].to_s
      self.pointsize = 250
      self.interline_spacing = -100
 
      }  

  imgFrame = Magick::Image.new(600, 600) 
  draw = Magick::Draw.new
  draw.fill = "#00000099"
  draw.pointsize = 33
  draw.gravity = Magick::SouthGravity
  dolltype_no = "#{DOLL_TYPE}_#{i+1}"
  draw.annotate(imgFrame, 0, 0, 0, 10, dolltype_no)
  result = imgFrame.composite(img,Magick::CenterGravity, Magick::MultiplyCompositeOp)
  imgwh = Magick::Image.new(750, 750) {
    self.background_color = 'white'
  }
  result =imgwh.composite(result, Magick::CenterGravity, 0, 0, Magick::MultiplyCompositeOp)
  result.write("PNG8:output/#{DOLL_TYPE}_#{i+1}.png")
  puts "created: output/#{DOLL_TYPE}_#{i+1}.png"
  GC.start
}