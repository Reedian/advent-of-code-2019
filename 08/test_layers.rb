require 'minitest/autorun'
require_relative 'image_processor'

class TestLayers < Minitest::Test
  def test_parse_layers
    assert_equal(
      [[1,2,3,4,5,6],[7,8,9,0,1,2]],
      test_input_object.parse_layers
    )
  end

  def test_find_fewest_0_layer
    assert_equal(
      [1,2,3,4,5,6],
      test_input_object.find_fewest_0_layer
    )
  end

  def test_layer_code
    assert_equal(1, ImageProcessor.layer_code(test_input_object.find_fewest_0_layer))
  end

  private

  def test_input_object
    ImageProcessor.new('test_input.txt', width: 3, height: 2)
  end
end
