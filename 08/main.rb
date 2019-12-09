require_relative 'image_processor'

layer = ImageProcessor.new('input.txt', width: 25, height: 6).find_fewest_0_layer
code = ImageProcessor.layer_code(layer)

puts code
