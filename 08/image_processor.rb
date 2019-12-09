require_relative 'file_reader'

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

  private

  attr_reader :input, :width, :height
end
