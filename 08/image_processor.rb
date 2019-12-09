require_relative 'file_reader'
require 'colorize'

class ImageProcessor
  def initialize(filename, width:, height:)
    @input = FileReader.new(filename).call
    @width = width
    @height = height
  end

  def parse_layers
    input.split('').map(&:to_i).each_slice(width*height).to_a
  end

  def find_fewest_0_layer
    parse_layers.min { |layer_a, layer_b| layer_a.count(0) <=> layer_b.count(0) }
  end

  def self.layer_code(layer)
    layer.count(1) * layer.count(2)
  end

  def self.format_matrix(matrix)
    matrix.map do |segment|
      segment.map { |pixel| pixel.to_s.colorize(pixel.zero? ? :white : :red) }
    end
  end

  def decode
    decoded_pixels = []
    (width * height).times do |index|
      parse_layers.each do |layer|
        decoded_pixels[index] = layer[index]
        break if decoded_pixels[index] < 2
      end
    end
    decoded_pixels.each_slice(width).to_a
  end

  private

  attr_reader :input, :width, :height
end
