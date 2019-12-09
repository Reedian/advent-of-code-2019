require_relative 'image_processor'

processed_image = ImageProcessor.new('input.txt', width: 25, height: 6)

# Part 1
layer = processed_image.find_fewest_0_layer
code = ImageProcessor.layer_code(layer)

puts code

# Part 2

decoded_matrix = processed_image.decode
formated_matrix = ImageProcessor.format_matrix(decoded_matrix)

puts formated_matrix.map(&:join).join("\n")
